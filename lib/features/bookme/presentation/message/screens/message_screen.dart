import 'package:bookme/core/presentation/theme/hint_color.dart';
import 'package:bookme/core/utitls/date_formatter.dart';
import 'package:bookme/features/bookme/presentation/chat/arguments/chat_argument.dart';
import 'package:bookme/features/bookme/presentation/message/getx/message_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../../../core/presentation/theme/primary_color.dart';
import '../../../data/models/response/message/message_model.dart';

class MessageScreen extends GetView<MessageController> {
  const MessageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ChatArgument? args =
        ModalRoute.of(context)?.settings.arguments as ChatArgument?;
    if (args != null) {
      controller.getChat(args.chat);
    }
    return Scaffold(
      appBar: AppBar(),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Column(
          children: <Widget>[
            Expanded(child: _buildMessageList(context)),
            _buildTextComposer(context)
          ],
        ),
      ),
    );
  }

  Widget _buildMessageList(BuildContext context) {
    return Obx(
      () => RefreshIndicator(
        onRefresh: () => Future<void>.sync(() {
          controller.getMessages(1);
        }),
        child: ListView.builder(
          // shrinkWrap: true,
          physics: const BouncingScrollPhysics(),
          reverse: true,
          controller: controller.scrollController,
          itemCount: controller.messages.length,
          itemBuilder: (BuildContext context, int index) {
            return _buildMessageCard(controller.messages[index], context);
          },
        )
        /*PagedListView<int, Message>.separated(
          pagingController: controller.pagingController,
          reverse: true,
          builderDelegate: PagedChildBuilderDelegate<Message>(
            itemBuilder: (BuildContext context, Message message, int index) {
              return _buildMessageCard(message, context);
            },
            firstPageErrorIndicatorBuilder: (BuildContext context) =>
                ErrorIndicator(
              error: controller.pagingController.value.error as Failure,
              onTryAgain: () => controller.pagingController.refresh(),
            ),
            noItemsFoundIndicatorBuilder: (BuildContext context) =>
                const EmptyListIndicator(),
            newPageProgressIndicatorBuilder: (BuildContext context) =>
                const Center(
              child: SizedBox.shrink(),
            ),
            firstPageProgressIndicatorBuilder: (BuildContext context) =>
                const Center(
              child: SizedBox.shrink(),
            ),
          ),
          //padding: AppPaddings.lA,
          separatorBuilder: (BuildContext context, int index) =>
              const SizedBox.shrink(),
        )*/
        ,
      ),
    );
  }

  Widget _buildMessageCard(Message message, BuildContext context) {
    final bool isUser = message.receiver!.id != controller.user.value.id;
    return _buildMessageBubble(context, message, isUser);
  }

  Container _buildMessageBubble(
      BuildContext context, Message message, bool isUser) {
    //todo Implement message time
    return Container(
      // alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      // Adjust alignment based on isUser
      margin: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment:
            isUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            child: Container(
              decoration: BoxDecoration(
                  boxShadow: const <BoxShadow>[
                    BoxShadow(
                      color: Colors.black12,
                      // Shadow color
                      offset: Offset(0, 2),
                      // Position the shadow above the container
                      blurRadius: 1,
                      // Spread of the shadow
                      spreadRadius: 1, // Spread of the shadow
                    ),
                  ],
                  color: isUser
                      ? Theme.of(context).primaryColor
                      : Colors.grey.shade300.withOpacity(0.5),
                  borderRadius: BorderRadius.only(
                    topLeft: isUser ? const Radius.circular(10) : Radius.zero,
                    topRight: isUser ? Radius.zero : const Radius.circular(10),
                    bottomLeft: const Radius.circular(10),
                    bottomRight: const Radius.circular(10),
                  )),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SelectableText(
                  message.message.text.trimLeft(),
                  cursorColor: PrimaryColor.color,
                  // textAlign: isUser ? TextAlign.end : TextAlign.start,
                  style: TextStyle(
                    color: isUser ? Colors.white : Colors.black,
                  ),
                ),
              ),
            ),
          ),
          Row(
            children: <Widget>[
              Text(
                DataFormatter.getVerboseDateTimeRepresentation(
                  DateTime.parse(message.createdAt!),
                ),
                style: TextStyle(
                  fontSize: 12,
                  color: HintColor.color.shade200,
                ),
              ),
                Builder(builder: (BuildContext context) {
                  //Todo message status
                  return const SizedBox.shrink();
                })
            ],
          )
        ],
      ),
    );
  }

  Widget _buildTextComposer(BuildContext context) {
    return Obx(
      () => Container(
        height: 80,
        margin: const EdgeInsets.only(top: 30),
        decoration: BoxDecoration(
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              // Shadow color
              offset: const Offset(0, -4),
              // Position the shadow above the container
              blurRadius: 4,
              // Spread of the shadow
              spreadRadius: 2, // Spread of the shadow
            ),
          ],
          color: Colors.white,
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(50),
                        boxShadow: const <BoxShadow>[
                          BoxShadow(
                            offset: Offset(0, 5),
                            spreadRadius: -16,
                            blurRadius: 20,
                            color: Color.fromRGBO(0, 0, 0, 1),
                          )
                        ]),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      child: TextFormField(
                        controller:
                            controller.messageTextEditingController.value,
                        decoration: InputDecoration(
                          labelStyle: TextStyle(
                            color: Colors.white.withOpacity(0.2),
                          ),
                          border: InputBorder.none,
                          //  contentPadding: const EdgeInsets.all(8),
                          hintStyle: const TextStyle(
                            color: Colors.black54,
                          ),
                          hintText: 'Type something...',
                        ),
                        textCapitalization: TextCapitalization.sentences,
                        keyboardType: TextInputType.multiline,
                        maxLines: null,
                        inputFormatters: <TextInputFormatter>[
                          NoLeadingSpaceFormatter(),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              IconButton(
                icon: const Icon(
                  Icons.send,
                  color: PrimaryColor.color,
                ),
                onPressed: () {
                  controller.onFieldSubmitted();
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}

class NoLeadingSpaceFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (newValue.text.startsWith(' ')) {
      final String trimmedText = newValue.text.trimLeft();

      return TextEditingValue(
        text: trimmedText,
        selection: TextSelection(
          baseOffset: trimmedText.length,
          extentOffset: trimmedText.length,
        ),
      );
    }

    return newValue;
  }
}
