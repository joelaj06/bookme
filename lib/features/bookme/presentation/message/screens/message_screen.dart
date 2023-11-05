import 'package:bookme/features/bookme/presentation/message/getx/message_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
class MessageScreen extends GetView<MessageController> {
  const MessageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const Center(child: Text('Messages Here'),),
    );
  }
}
