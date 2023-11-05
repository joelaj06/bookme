import 'package:bookme/core/usecase/usecase.dart';
import 'package:bookme/features/bookme/data/models/request/message/message_request.dart';
import 'package:bookme/features/bookme/data/models/response/listpage/listpage.dart';
import 'package:bookme/features/bookme/data/models/response/message/message_content_model.dart';
import 'package:bookme/features/bookme/data/models/response/message/message_model.dart';
import 'package:bookme/features/bookme/domain/usecases/message/fetch_messages.dart';
import 'package:bookme/features/bookme/domain/usecases/message/post_message.dart';
import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../../../../core/errors/failure.dart';

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

  final PagingController<int, Message> pagingController =
      PagingController<int, Message>(firstPageKey: 1);

  @override
  void dispose() {
    pagingController.dispose();
    super.dispose();
  }

  void sendMessage() async {
    final MessageContent messageContent = MessageContent(text: message.value);
    final Either<Failure, Message> failureOrMessage = await postMessage(
      MessageRequest(
        recipient: recipient,
        message: messageContent,
        chatId: chatId,
      ),
    );
    failureOrMessage.fold(
      (Failure failure) {},
      (Message message) {},
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
