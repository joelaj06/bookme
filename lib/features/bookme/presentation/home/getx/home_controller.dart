import 'package:bookme/core/presentation/routes/app_routes.dart';
import 'package:get/get.dart';
class HomeController extends GetxController{

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



  void navigateToPromotionsPage() async{
    await Get.toNamed<dynamic>(AppRoutes.promotions);
  }

  void navigateToServicesPage() async{
    await Get.toNamed<dynamic>(AppRoutes.services);
  }
}