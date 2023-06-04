import 'package:get/get.dart';

import '../../../../../core/presentation/routes/app_routes.dart';

class FavoritesController extends GetxController{

  final String company = 'Hermeland Studios';
  final String description =  'Book for all your creative photos, videos and '
      'studio shoots. I do door to door service. I do '
      'Birthday parties, engagements, funerals, picnics';


  void navigateToServiceDetailsScreen(int index) async{
    await Get.toNamed<dynamic>(AppRoutes.serviceDetails,
        arguments: index);
  }

}