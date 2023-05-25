import 'package:bookme/features/bookme/presentation/bookings/getx/bookings_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
class BookingsScreen extends GetView<BookingsController> {
  const BookingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Bookings'),
      ),
    );
  }
}
