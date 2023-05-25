import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../../../core/presentation/routes/app_routes.dart';

class PromotionsController extends GetxController{

  final Rx<TextEditingController> searchQueryTextEditingController =
      TextEditingController().obs;
  RxString query = ''.obs;




  void navigateToServiceDetailsScreen(int index) async{
    await Get.toNamed<dynamic>(AppRoutes.serviceDetails,
        arguments: index);
  }

  void clearSearchField(){
    query('');
    searchQueryTextEditingController.value.text = '';
  }

  void onSearchServiceQueryChange(String? value){
    query(value);
    searchQueryTextEditingController.value.text = value ?? '';
  }

}