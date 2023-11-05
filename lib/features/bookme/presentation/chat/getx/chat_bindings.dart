import 'package:bookme/features/bookme/domain/usecases/chat/fetch_user_chats.dart';
import 'package:bookme/features/bookme/domain/usecases/chat/initiate_chat.dart';
import 'package:bookme/features/bookme/presentation/chat/getx/chat_controller.dart';
import 'package:get/get.dart';

class ChatBindings extends Bindings{
  @override
  void dependencies() {
   Get.put<ChatController>(
     ChatController(fetchUserChats: FetchUserChats(
       bookmeRepository: Get.find(),
     ), initiateNewChat: InitiateNewChat(
       bookmeRepository: Get.find(),
     )),
   );
  }

}