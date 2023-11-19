import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../../../core/presentation/widgets/app_dialog.dart';

class SignUpController extends GetxController {
  RxBool isAgent = false.obs;

  void onAccountTypeSelected(BuildContext context,bool value) {
    final String accType = value ? 'Agent': 'Client';
    AppDialog().showConfirmationDialog(
      context,
      accType,
      'Are you sure you want to continue as ${value ? 'an': 'a'} $accType?',
      onTapConfirm: () {
        Navigator.pop(context);
        isAgent(value);
      },
    );
  }
}
