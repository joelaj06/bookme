import 'package:bookme/features/bookme/presentation/favorites/getx/favorites_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../core/presentation/theme/hint_color.dart';
import '../../../../../core/presentation/theme/primary_color.dart';
import '../../../../../core/presentation/utitls/app_padding.dart';
import '../../../../../core/presentation/utitls/app_spacing.dart';
import '../../../../../core/presentation/widgets/location_icon.dart';
class FavoriteScreen extends GetView<FavoritesController> {
  const FavoriteScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorites'),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: _buildServiceListTile(context,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildServiceListTile(BuildContext context){
    final double width = MediaQuery.of(context).size.width;
    return ListView.builder(
        itemCount: 10,
        physics: const BouncingScrollPhysics(),
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index){
          return Padding(
            padding: AppPaddings.mA,
            child: GestureDetector(
              onTap: () {
                controller.navigateToServiceDetailsScreen(index);
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
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Hero(
                          tag: 'service$index',
                          child: Image.asset('assets/images/photographer.png'),
                        ),
                      ),
                      const AppSpacing(h: 10,),
                      Flexible(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              controller.company,
                              style: context.textTheme.bodyMedium?.copyWith(
                                  fontSize: 15, fontWeight: FontWeight.w500),
                            ),
                            const IconText(text: 'Kasoa, Ofankor'),
                            Expanded(
                              child: SizedBox(
                                child: Text(
                                  controller.description,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                  style: TextStyle(color: HintColor.color.shade400),
                                ),
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
}
