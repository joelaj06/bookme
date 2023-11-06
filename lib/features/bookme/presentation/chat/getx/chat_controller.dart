import 'package:bookme/core/presentation/routes/app_routes.dart';
import 'package:bookme/core/usecase/usecase.dart';
import 'package:bookme/features/bookme/data/models/request/chat/chat_request.dart';
import 'package:bookme/features/bookme/data/models/response/chat/chat_model.dart';
import 'package:bookme/features/bookme/data/models/response/chat/initiate_chat_model.dart';
import 'package:bookme/features/bookme/data/models/response/listpage/listpage.dart';
import 'package:bookme/features/bookme/domain/usecases/chat/fetch_user_chats.dart';
import 'package:bookme/features/bookme/domain/usecases/chat/initiate_chat.dart';
import 'package:bookme/features/bookme/presentation/chat/arguments/chat_argument.dart';
import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../../../../core/errors/failure.dart';

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

  final PagingController<int, Chat> pagingController =
      PagingController<int, Chat>(firstPageKey: 1);

  @override
  void onInit() {
    pagingController.addPageRequestListener((int pageKey) {
      getUserChats(pageKey);
    });
    super.onInit();
  }

  void navigateToMessages(Chat chat) {
     Get.toNamed<dynamic>(AppRoutes.messages,
     arguments: ChatArgument(chat));
  }

  void getUserChats(int pageKey) async {
    final Either<Failure, ListPage<Chat>> failureOrChats =
        await fetchUserChats(NoParams());
    failureOrChats.fold(
      (Failure failure) {
        pagingController.error = failure;
      },
      (ListPage<Chat> newPage) {
        final int previouslyFetchedItemsCount =
            pagingController.itemList?.length ?? 0;

        final bool isLastPage = newPage.isLastPage(previouslyFetchedItemsCount);
        final List<Chat> newItems = newPage.itemList;
        chats(newItems);
        if (isLastPage) {
          pagingController.appendLastPage(newItems);
        } else {
          final int nextPageKey = pageKey + 1;
          pagingController.appendPage(newItems, nextPageKey);
        }
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
}
