import 'package:bookme/core/presentation/routes/app_routes.dart';
import 'package:bookme/core/usecase/usecase.dart';
import 'package:bookme/core/utitls/shared_preferences_wrapper.dart';
import 'package:bookme/core/utitls/shared_prefs_keys.dart';
import 'package:bookme/features/bookme/data/models/request/chat/chat_request.dart';
import 'package:bookme/features/bookme/data/models/request/message/message_request.dart';
import 'package:bookme/features/bookme/data/models/response/chat/chat_model.dart';
import 'package:bookme/features/bookme/data/models/response/chat/initiate_chat_model.dart';
import 'package:bookme/features/bookme/data/models/response/listpage/listpage.dart';
import 'package:bookme/features/bookme/domain/usecases/chat/fetch_user_chats.dart';
import 'package:bookme/features/bookme/domain/usecases/chat/initiate_chat.dart';
import 'package:bookme/features/bookme/presentation/chat/arguments/chat_argument.dart';
import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

import '../../../../../core/errors/failure.dart';
import '../../../../../core/utitls/app_socket_client.dart';
import '../../../../authentication/data/datasource/auth_local_data_source.dart';
import '../../../../authentication/data/models/response/login/login_response.dart';
import '../../../../authentication/data/models/response/user/user_model.dart';
import '../../message/getx/message_controller.dart';

class ChatController extends GetxController {
  ChatController({
    required this.fetchUserChats,
    required this.initiateNewChat,
  });

  final InitiateNewChat initiateNewChat;
  final FetchUserChats fetchUserChats;

  //reactive variables
  RxString chatId = ''.obs;
  RxList<Chat> chats = <Chat>[].obs;
  Rx<User> user = User.empty().obs;
  RxList<OnlineUser> activeUsers = <OnlineUser>[].obs;
  RxList<MessageRequest> notifications = <MessageRequest>[].obs;
  RxList<MessageRequest> unreadNotifications = <MessageRequest>[].obs;

  final PagingController<int, Chat> pagingController =
      PagingController<int, Chat>(firstPageKey: 1);
  final AuthLocalDataSource _authLocalDataSource = Get.find();
  final AppSocketClient _socketClient = AppSocketClient();
  late IO.Socket socketIO;
  final SharedPreferencesWrapper _sharedPreferencesWrapper = Get.find();

  @override
  void onInit() {
    connectToSocket();
    getUserChats(1);
    retrieveNotificationPersistedData();
    super.onInit();
  }

  @override
  void onClose() {
    _socketClient.disconnect();
    super.onClose();
  }

  void retrieveNotificationPersistedData() async {
    final List<Map<String, dynamic>>? results = await _sharedPreferencesWrapper
        .getList(SharedPrefsKeys.messageNotification);
    final List<MessageRequest> res = List<MessageRequest>.from(
      results!.map<MessageRequest>(
        (dynamic json) => MessageRequest.fromJson(json as Map<String, dynamic>),
      ),
    );
    unreadNotifications(res);
  }

  void clearUnreadNotifications() async {
    await _sharedPreferencesWrapper.remove(SharedPrefsKeys.messageNotification);
  }

  void persistUnreadMessageNotification() async {
    final List<Map<String, dynamic>> data = unreadNotifications
        .map((MessageRequest messageRequest) => messageRequest.toJson())
        .toList();
    await _sharedPreferencesWrapper.setList(
        SharedPrefsKeys.messageNotification, data);
  }

  void connectToSocket() async {
    //todo socket event refactoring
    await getUser();
    //establish socket connection
    socketIO = _socketClient.init(
        onSocketConnected: (IO.Socket socket) {},
        onSocketDisconnected: (IO.Socket socket) {});
    socketIO.emit('register', user.value.id);
    socketIO.on('registered-users', (dynamic data) {
      if (data is List) {
        final List<OnlineUser> onlineUsers = (data).map((dynamic user) {
          return OnlineUser(
              userId: user['userId'] as String,
              socketId: user['socketId'] as String);
        }).toList();
        activeUsers(onlineUsers);
      }
    });

    //get message notification
    socketIO.on('get-notification', (dynamic data) {
      final Map<String, dynamic> json = data as Map<String, dynamic>;
      final MessageRequest message = MessageRequest.fromJson(json);
      if (Get.currentRoute == AppRoutes.messages) {
        notifications.add(message.copyWith(isRead: true));
      } else {
        notifications.add(message);
      }
      getUnreadNotifications();
      getUserChats(1);
    });
  }

  Rx<List<MessageRequest>> getUserNotifications(Chat chat) {
    final String senderId = getRecipient(chat).id;
    final RxList<MessageRequest> result = unreadNotifications
        .where((MessageRequest n) => n.senderId == senderId)
        .toList()
        .obs;
    return result.obs;
  }

  void getUnreadNotifications() {
    unreadNotifications.clear();
    final List<MessageRequest> results =
        notifications.where((MessageRequest n) => n.isRead == false).toList();
    unreadNotifications.addAll(results);
    // Sort the messages based on the date in descending order
    unreadNotifications.sort(
      (MessageRequest a, MessageRequest b) => DateTime.parse(b.date!).compareTo(
        DateTime.parse(a.date!),
      ),
    );

    persistUnreadMessageNotification();
  }

  Future<void> getUser() async {
    final LoginResponse? response =
        await _authLocalDataSource.getAuthResponse();
    user(response?.user);
  }

  void navigateToMessages(Chat chat, int index) {
    final String senderId = getRecipient(chat).id;
    if(getUserNotifications(chat).value.isNotEmpty){
    chats[index] = chat.copyWith(
        lastMessage: getUserNotifications(chat).value.first.message.text);
    }
    if (getUserNotifications(chat).value.isNotEmpty) {
      for (int i = 0; i < notifications.length; i++) {
        if (notifications[i].senderId == senderId) {
          notifications[i] = notifications[i].copyWith(isRead: true);
        }
      }
      getUnreadNotifications();
    }
    Get.toNamed<dynamic>(AppRoutes.messages, arguments: ChatArgument(chat));
  }

  void getUserChats(int pageKey) async {
    final Either<Failure, ListPage<Chat>> failureOrChats =
        await fetchUserChats(NoParams());
    failureOrChats.fold(
      (Failure failure) {
        //  pagingController.error = failure;
      },
      (ListPage<Chat> newPage) {
        final List<Chat> newItems = newPage.itemList;
        chats(newItems);

      },
    );
  }

  void initiateANewChat(String user) async {
    final ChatRequest chatRequest = ChatRequest(user: user);
    final Either<Failure, InitiateChat> failureOrChat =
        await initiateNewChat(chatRequest);
    failureOrChat.fold(
      (Failure failure) {},
      (InitiateChat chat) {
        chatId(chat.chatRoomId);
      },
    );
  }

  User getRecipient(Chat chat) {
    final List<User> users = <User>[];
    users.add(chat.user);
    users.add(chat.initiator ?? User.empty());
    final User recipient = users.firstWhere((User el) => el.id != user.value.id,
        orElse: () => User.empty());
    return recipient;
  }
}
