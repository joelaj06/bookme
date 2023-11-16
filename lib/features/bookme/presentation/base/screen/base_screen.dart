import 'package:bookme/core/presentation/theme/primary_color.dart';
import 'package:flutter/material.dart';

import '../../../../../core/presentation/nav/bottom_nav_icons.dart';
import '../../../../../core/presentation/nav/bottom_nav_tabs.dart';

class BaseScreen extends StatefulWidget {
  const BaseScreen({Key? key}) : super(key: key);

  @override
  State<BaseScreen> createState() => _BaseScreenState();
}

int _selectedIndexItem = 0;

class _BaseScreenState extends State<BaseScreen> {
  @override
  Widget build(BuildContext context) {
    final List<Widget> navBarItemList = <Widget>[];

    for (int i = 0; i < navIconList.length; i++) {
      navBarItemList.add(
        _buildNavIconContainer(context,
            i == _selectedIndexItem ? navIconSolidList[i] : navIconList[i], i),
      );
    }
    return Scaffold(
      body: navPages[_selectedIndexItem],
      bottomNavigationBar: Row(children: navBarItemList),
    );
  }

  Widget _buildNavIconContainer(
      BuildContext context, IconData icon, int index) {
    final double width = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedIndexItem = index;
        });
      },
      child: Container(
        color: Colors.transparent,
        height: 60,
        width: width / navIconList.length,
        child: Column(
          children: <Widget>[
            Icon(
              icon,
              color: index == _selectedIndexItem
                  ? PrimaryColor.color
                  : Colors.grey,
            ),
            FittedBox(
              fit: BoxFit.fill,
              child: Text(
                navIconText[index],
                style: TextStyle(
                  color: index == _selectedIndexItem
                      ? PrimaryColor.color
                      : Colors.grey,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
