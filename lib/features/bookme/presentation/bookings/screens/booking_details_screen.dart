import 'package:bookme/core/presentation/theme/primary_color.dart';
import 'package:bookme/core/presentation/utitls/app_padding.dart';
import 'package:bookme/core/presentation/utitls/app_spacing.dart';
import 'package:bookme/core/presentation/widgets/app_text_input_field.dart';
import 'package:bookme/features/bookme/presentation/bookings/getx/bookings_controller.dart';
import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';

import '../../../../../core/presentation/theme/hint_color.dart';
import '../../../../../core/presentation/widgets/app_button.dart';

class BookingDetailsScreen extends GetView<BookingsController> {
  const BookingDetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<DateTime?> initialDates = <DateTime>[
      DateTime.now().subtract(const Duration(days: 1)),
      DateTime.now(),
    ];
    return Scaffold(
      appBar: AppBar(
        title: const Text('Booking Details'),
      ),
      bottomNavigationBar: _buildBottomNavigationItems(context),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: AppPaddings.mA,
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                   Text('Dates',
                    style: context.textTheme.headline6?.copyWith(
                     // fontSize: 30,
                      color: HintColor.color.shade800,
                    ),),
                  TextButton(
                    onPressed: () {
                      controller.dialogCalendarPickerValue(initialDates);
                    },
                    child: const Text('Clear',),
                  )
                ],
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                    boxShadow: const <BoxShadow>[
                      BoxShadow(
                        offset: Offset(3, 3),
                        spreadRadius: -8,
                        blurRadius: 10,
                        color: Color.fromRGBO(137, 137, 137, 1),
                      )
                    ],
                ),
                child: Obx(
                  () => CalendarDatePicker2(
                    config: CalendarDatePicker2Config(
                      calendarType: CalendarDatePicker2Type.range,
                    ),
                    value: controller.dialogCalendarPickerValue,
                    onValueChanged: controller.onDateDateValueChanged,
                  ),
                ),
              ),
             const AppSpacing(v: 10,),
             SizedBox(
               width: MediaQuery.of(context).size.width,
               child: Row(
                 children: <Widget>[
                   Expanded(
                     child: Obx(() =>AppTextInputField(
                         controller: controller.startTimeTextEditingController.value,
                         labelText: 'Begin',
                         readOnly: true,
                         suffixIcon: IconButton(
                           onPressed: (){
                             controller.onTimeSelected(context, true);
                           },
                           icon: const Icon(Icons.schedule),
                         ),
                       ),
                     ),
                   ),
                   const AppSpacing(h: 10,),
                   Expanded(
                     child: Obx(() => AppTextInputField(
                         controller: controller.endTimeTextEditingController.value,
                         labelText: 'End',
                         readOnly: true,
                         suffixIcon: IconButton(
                           onPressed: (){
                             controller.onTimeSelected(context, false);
                           },
                           icon: const Icon(Icons.schedule),
                         ),
                       ),
                     ),
                   ),
                 ],
               ),
             ),
              AppTextInputField(
                labelText: 'Location',
                initialValue: 'Accra - Santa Maria',
                onChanged: controller.onLocationInputChanged,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(
                    children:  <Widget>[
                      const Icon(Ionicons.person_circle_outline),
                      const AppSpacing(h: 10,),
                      Text('John Doe',
                        style: context.textTheme.bodyLarge?.copyWith(
                          fontSize: 20,
                        ),),
                    ],
                  ),
                  TextButton(
                    onPressed: () {},
                    child: const Text('View Profile'),
                  ),
                ],
              ),
               Row(
                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 children: <Widget>[
                    Text('Preliminary Cost',
                      style: context.textTheme.bodyLarge?.copyWith(
                        fontSize: 20,
                      ),),
                   FittedBox(
                     fit: BoxFit.fill,
                     child: Text('Ghc 1,500',
                       style: context.textTheme.bodyLarge?.copyWith(
                         fontSize: 20,
                         color: PrimaryColor.color,
                         //fontWeight: FontWeight.w500,
                       ),),
                   ),

                 ],
               ),
              Row(
                children:const <Widget>[
                  Text('Job Description:'),
                  AppSpacing(h: 10,),
                  Flexible(
                    child: Text('Wedding Photoshoot',
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }


  Widget _buildBottomNavigationItems(BuildContext context) {
    //final double width = MediaQuery.of(context).size.width;
    return Container(
      height: 80,
      padding: AppPaddings.mA,
      // color: Colors.red,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        //mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
         /* Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
            ),
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: width * 0.3,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget> [
                   Text('Preliminary Cost',
                      style: TextStyle(
                        color: HintColor.color.shade200,
                      ),),
                  FittedBox(
                    fit: BoxFit.fill,
                    child: Text('Ghc 1,500',
                      style: context.textTheme.bodyLarge?.copyWith(
                        fontSize: 30,
                        color: HintColor.color.shade800,
                        fontWeight: FontWeight.w500,
                      ),),
                  ),

                ],
              ),
            ),
          ),*/
          Flexible(
            child: AppButton(
              onPressed: () {
                controller.onBookingCanceled(context);
              },
              text: 'Cancel',
              backgroundColor: Colors.red,
            ),
          ),
          const AppSpacing(h: 10,),
          Flexible(
            child: AppButton(
              onPressed: () {
                print('Tapped');
              },
              text: 'Reschedule',
            ),
          ),
        ],
      ),
    );
  }
}
