import 'package:bookme/features/bookme/domain/usecases/message/fetch_messages.dart';
import 'package:bookme/features/bookme/domain/usecases/message/post_message.dart';
import 'package:bookme/features/bookme/presentation/message/getx/message_controller.dart';
import 'package:get/get.dart';

class MessageBindings extends Bindings{
  @override
  void dependencies() {
    Get.put<MessageController>(
      MessageController(postMessage: PostMessage(
        bookmeRepository: Get.find(),
      ), fetchMessages: FetchMessages(
        bookmeRepository: Get.find(),
      ))
    );
  }

}