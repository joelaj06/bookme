import 'package:bookme/features/bookme/presentation/promotions/getx/promotions_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
class PromotionsScreen extends GetView<PromotionsController> {
  const PromotionsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Promotions'),
      ),
    );
  }
}
