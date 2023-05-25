import 'package:bookme/core/presentation/routes/app_routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class ServicesController extends GetxController{

  //reactive variables
  final RxInt selectedCategory = 0.obs;
  final List<String> categories =<String>[
    'All',
    'Beauty and Personal Care',
    'Home Services',
    'Event Services',
    'Health and Wellness',
    'Tutoring and Education',
    'Automotive Services',
    'Pet Services',
    'Fitness and Sports',
    'Travel and Transportation',
    'Fashion and Clothing',
  ];
  final Rx<TextEditingController> searchQueryTextEditingController =
      TextEditingController().obs;
  final RxString query = ''.obs;
  final String company = 'Hermeland Studios';
  final String description =  'Book for all your creative photos, videos and '
      'studio shoots. I do door to door service. I do '
      'Birthday parties, engagements, funerals, picnics';
  final RxInt imageIndex = 0.obs;




  void onOtherImagesSelected(int index){
    imageIndex(index);
  }

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