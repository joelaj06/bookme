import 'package:bookme/core/presentation/utitls/app_padding.dart';
import 'package:bookme/features/bookme/presentation/chat/getx/chat_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../../../../core/errors/failure.dart';
import '../../../../../core/presentation/theme/primary_color.dart';
import '../../../../../core/presentation/utitls/app_spacing.dart';
import '../../../../../core/presentation/widgets/exception_indicators/empty_list_indicator.dart';
import '../../../../../core/presentation/widgets/exception_indicators/error_indicator.dart';
import '../../../../../core/utitls/base_64.dart';
import '../../../../../core/utitls/date_formatter.dart';
import '../../../../authentication/data/models/response/user/user_model.dart';
import '../../../data/models/response/chat/chat_model.dart';

class ChatScreen extends GetView<ChatController> {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chats'),
      ),
      body: _buildChatList(context),
    );
  }

  Widget _buildChatList(BuildContext context) {
    return Obx(
      () => ListView.builder(
          itemCount: controller.chats.length,
          itemBuilder: (BuildContext context, int index) {
            return _buildChatCard(context, controller.chats[index]);
          }),
    );
    /*return PagedListView<int, Chat>.separated(
      pagingController: controller.pagingController,
      builderDelegate: PagedChildBuilderDelegate<Chat>(
        itemBuilder: (BuildContext context, Chat chat, int index) {
          return _buildChatCard(context, chat);
        },
        firstPageErrorIndicatorBuilder: (BuildContext context) =>
            ErrorIndicator(
          error: controller.pagingController.value.error as Failure,
          onTryAgain: () => controller.pagingController.refresh(),
        ),
        noItemsFoundIndicatorBuilder: (BuildContext context) =>
            const EmptyListIndicator(),
        newPageProgressIndicatorBuilder: (BuildContext context) => const Center(
          child: CircularProgressIndicator.adaptive(),
        ),
        firstPageProgressIndicatorBuilder: (BuildContext context) =>
            const Center(
          child: CircularProgressIndicator.adaptive(),
        ),
      ),
      //padding: AppPaddings.lA,
      separatorBuilder: (BuildContext context, int index) =>
          const SizedBox.shrink(),
    );*/
  }

  Widget _buildChatCard(BuildContext context, Chat chat) {
    final User user = controller.getRecipient(chat);
    final String image = user.image ?? '';
    return GestureDetector(
      onTap: () {
        controller.navigateToMessages(chat);
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: CircleAvatar(
                        child: image.isEmpty
                            ? Image.asset('assets/images/user2.jpg')
                            : Image.memory(
                                fit: BoxFit.cover,
                                Base64Convertor().base64toImage(
                                  image,
                                ),
                              ),
                      ),
                    ),
                    const AppSpacing(
                      h: 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          '${user.firstName} ${user.lastName}',
                          style: const TextStyle(
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Obx(
                          () => Text(
                            controller.getUserNotifications(chat).value.isEmpty
                                ? chat.lastMessage.toString()
                                : controller
                                    .getUserNotifications(chat)
                                    .value
                                    .first
                                    .message
                                    .text,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Obx(
                      () => Text(
                        controller.getUserNotifications(chat).value.isEmpty
                            ? ''
                            : DataFormatter.getVerboseDateTimeRepresentation(
                                DateTime.parse(controller
                                        .getUserNotifications(chat)
                                        .value
                                        .first
                                        .date ??
                                    DateTime.now().toIso8601String()),
                              ),
                        style: const TextStyle(
                          fontSize: 12,
                        ),
                      ),
                    ),
                    CircleAvatar(
                      radius: 10,
                      child: Obx(
                        () => Text(
                          controller
                              .getUserNotifications(chat)
                              .value
                              .length
                              .toString(),
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 10,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
            const Divider(),
          ],
        ),
      ),
    );
  }
}
