import 'package:bookme/core/usecase/usecase.dart';
import 'package:bookme/core/utitls/app_socket_client.dart';
import 'package:bookme/features/authentication/data/datasource/auth_local_data_source.dart';
import 'package:bookme/features/authentication/data/models/response/login/login_response.dart';
import 'package:bookme/features/bookme/data/models/request/message/message_request.dart';
import 'package:bookme/features/bookme/data/models/response/listpage/listpage.dart';
import 'package:bookme/features/bookme/data/models/response/message/message_content_model.dart';
import 'package:bookme/features/bookme/data/models/response/message/message_model.dart';
import 'package:bookme/features/bookme/domain/usecases/message/fetch_messages.dart';
import 'package:bookme/features/bookme/domain/usecases/message/post_message.dart';
import 'package:bookme/features/bookme/presentation/chat/getx/chat_controller.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

import '../../../../../core/errors/failure.dart';
import '../../../../authentication/data/models/response/user/user_model.dart';
import '../../../data/models/response/chat/chat_model.dart';

class MessageController extends GetxController {
  MessageController({
    required this.postMessage,
    required this.fetchMessages,
  });

  final FetchMessages fetchMessages;
  final PostMessage postMessage;

  //reactive variables
  RxBool isLoading = false.obs;
  RxList<Message> messages = <Message>[].obs;
  String chatId = '';
  String recipient = '';
  RxString message = ''.obs;
  Rx<User> user = User
      .empty()
      .obs;
  RxBool isMessageSuccess = false.obs;

  final PagingController<int, Message> pagingController =
  PagingController<int, Message>(firstPageKey: 1);

  final AuthLocalDataSource _authLocalDataSource = Get.find();
  final Rx<
      TextEditingController> messageTextEditingController = TextEditingController()
      .obs;
  final ScrollController scrollController = ScrollController();
  late IO.Socket socketIO;
  final AppSocketClient _socketClient = AppSocketClient();
  final ChatController _chatController = Get.find();



  @override
  void onInit() {
    getUser();
    connectSocket();
    /* pagingController.addPageRequestListener((int pageKey) {
      getMessages(pageKey);
    });*/
    super.onInit();
  }

  @override
  void onClose() {
    _socketClient.disconnect();
    pagingController.dispose();
    super.onClose();
  }


  void connectSocket(){
    //establish socket connection
   socketIO = _socketClient.init(
         onSocketConnected: onSocketConnected,
        onSocketDisconnected:  onSocketDisconnected
    );
    socketIO.emit('register',_chatController.user.value.id);
    socketIO.on('registered-users', (dynamic data)  {});
   socketIO.on('receive-message', (dynamic data) {
     final Map<String, dynamic> json = data as Map<String, dynamic>;
     final MessageContent messageContent = MessageContent(text: (json['message']['message_text']).toString());
     final Message message = Message(
       id: '',
       message: messageContent,
       receiver: User(id: json['recipient'] as String,
       firstName: '',
       lastName: '', email: '', isAgent: false,
         createdAt: DateTime.now().toIso8601String(),
       ),
     );
     messages.insert(0, message);
     getMessages(1);
   });
  }

  void emitMessageToRecipient(MessageRequest request){
    //send realtime message to receiver
    socketIO.emit('send-message',request.toJson());

  }

  void onSocketConnected(IO.Socket socket){

  }
  void onSocketDisconnected(IO.Socket socket){

  }


  Future<void> onFieldSubmitted() async {
    if(messageTextEditingController.value.text.isEmpty){
      return;
    }
    message(messageTextEditingController.value.text);
    messageTextEditingController.value.text = '';

    await sendMessage();
    // Move the scroll position to the bottom
    await scrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void getChat(Chat chat) {
    chatId = chat.id;
    recipient = _chatController.getRecipient(chat).id;
    getMessages(1);
  }

  void getUser() async {
    final LoginResponse? response = await _authLocalDataSource
        .getAuthResponse();
    user(response?.user);
  }

  Future<void> sendMessage() async {
    isLoading(true);
    final MessageContent messageContent = MessageContent(text: message.value);
    final MessageRequest messageRequest = MessageRequest(
      recipient: recipient,
      message: messageContent,
      chatId: chatId,
    );
    emitMessageToRecipient(messageRequest);
    final Message tempMessage = Message(
      id: '',
      receiver: const User(id: '',
        firstName: '',
        lastName: '',
        email: '',
        isAgent: false,),
      message: messageContent,
      createdAt: DateTime.now().toIso8601String(),
    );
    messages.insert(0,tempMessage);
    final Either<Failure, Message> failureOrMessage = await postMessage(
        messageRequest
    );
    message('');
    failureOrMessage.fold(
          (Failure failure) {
        isLoading(false);
        pagingController.error = failure;
      },
          (Message message) {
        isLoading(false);
        getMessages(1);
      },
    );
  }

  void getMessages(int pageKey) async {
    final Either<Failure, ListPage<Message>> failureOrMessages =
    await fetchMessages(PageParams(page: 0, size: 0, chatId: chatId));
    failureOrMessages.fold(
          (Failure failure) {},
          (ListPage<Message> newPage) {
        final int previouslyFetchedItemsCount =
            pagingController.itemList?.length ?? 0;

        final bool isLastPage = newPage.isLastPage(previouslyFetchedItemsCount);
        final List<Message> newItems = newPage.itemList;
        messages(newItems);
        if (isLastPage) {
          pagingController.appendLastPage(newItems);
        } else {
          final int nextPageKey = pageKey + 1;
          pagingController.appendPage(newItems, nextPageKey);
        }
      },
    );
  }
}
