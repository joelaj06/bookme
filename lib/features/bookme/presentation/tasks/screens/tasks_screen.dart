import 'package:bookme/features/bookme/presentation/tasks/getx/tasks_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';

import '../../../../../core/presentation/theme/hint_color.dart';
import '../../../../../core/presentation/theme/primary_color.dart';
import '../../../../../core/presentation/utitls/app_padding.dart';
import '../../../../../core/presentation/utitls/app_spacing.dart';
class TasksScreen extends GetView<TasksController> {
  const TasksScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tasks'),

      ),
      body: Padding(
        padding: AppPaddings.mA,
        child: Column(
          children: <Widget>[
            _buildTabHeader(context),
            Expanded(
              child: _buildPageView(context),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPageView(BuildContext context) {
    return PageView(
      controller: controller.pageController,
      onPageChanged: controller.onPageChanged,
      children: <Widget>[
        _buildJobHistoryContainer(context,'pending', 'Fri 30th June, 2023'),
        _buildJobHistoryContainer(context,'completed', 'Sun 28th May, 2023')
      ],
    );
  }

  Widget _buildJobHistoryContainer(BuildContext context, String status,
      String date,) {
    final double width = MediaQuery.of(context).size.width;
    return ListView.builder(
        itemCount: 10,
        physics: const BouncingScrollPhysics(),
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index) {
          final bool isPending =  status == 'pending';
          return Padding(
            padding: AppPaddings.mA,
            child: GestureDetector(
              onTap: () {
                controller.navigateToBookingDetailsScreen(index);
              },
              child: Container(
                decoration: BoxDecoration(
                  color: PrimaryColor.backgroundColor,
                  borderRadius: BorderRadius.circular(15),
                  //  border: Border.all(color: Colors.red),
                  boxShadow: const <BoxShadow>[
                    BoxShadow(
                      offset: Offset(3, 3),
                      spreadRadius: -8,
                      blurRadius: 10,
                      color: Color.fromRGBO(137, 137, 137, 1),
                    ),
                  ],
                ),
                height: 100,
                width: width,
                child: Padding(
                  padding: AppPaddings.mA,
                  child: Row(
                    //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Hero(
                          tag: 'service$index',
                          child: Image.asset('assets/images/photographer.png'),
                        ),
                      ),
                      const AppSpacing(
                        h: 10,
                      ),
                      Flexible(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              'John Doe',
                              style: context.textTheme.bodyMedium?.copyWith(
                                  fontSize: 15, fontWeight: FontWeight.w500),
                            ),
                            const Text('Wedding Photoshoot'),
                            const SizedBox(
                              child: Text(
                                'Ghc 1200',
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(color: PrimaryColor.color),
                              ),
                            ),
                            Expanded(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children:  <Widget>[
                                  Text(
                                      date
                                  ),
                                  Icon( isPending ?Icons.pending_actions_outlined:
                                  Ionicons.checkmark_circle,
                                    color: isPending ? Color(0xffbb8833):
                                    Colors.green,)
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }

  Container _buildTabHeader(BuildContext context) {
    return Container(
      height: 60,
      padding: AppPaddings.mA,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: HintColor.color.shade50,
          )),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Expanded(
            child: GestureDetector(
              onTap: () {
                controller.onPageChanged(0);
                controller.navigatePages(0);
              },
              child: Obx(
                    () => _buildTabHeaderContent(
                  context,
                  text: 'Pending',
                  isActive: controller.pageIndex.value == 0,
                ),
              ),
            ),
          ),
          const AppSpacing(
            h: 10,
          ),
          Expanded(
            child: GestureDetector(
              onTap: () {
                controller.onPageChanged(1);
                controller.navigatePages(1);
              },
              child: Obx(
                    () => _buildTabHeaderContent(
                  context,
                  text: 'Completed',
                  isActive: controller.pageIndex.value == 1,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Container _buildTabHeaderContent(
      BuildContext context, {
        required String text,
        required bool isActive,
      }) {
    return Container(
      // width: MediaQuery.of(context).size.width / 2,
      decoration: isActive
          ? BoxDecoration(
        color: PrimaryColor.backgroundColor,
        borderRadius: BorderRadius.circular(10),
        boxShadow: const <BoxShadow>[
          BoxShadow(
            offset: Offset(0, 5),
            spreadRadius: -16,
            blurRadius: 20,
            color: Color.fromRGBO(0, 0, 0, 1),
          )
        ],
      )
          : null,
      child: Center(
        child: Text(
          text,
          style: TextStyle(
            fontSize: 16,
            color: isActive ? PrimaryColor.color : HintColor.color.shade300,
          ),
        ),
      ),
    );
  }
}


