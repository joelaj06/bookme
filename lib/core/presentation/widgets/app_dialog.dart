import 'package:flutter/cupertino.dart';
import 'package:panara_dialogs/panara_dialogs.dart';

class AppDialog {
  void showConfirmationDialog(
      BuildContext context, String title, String message,
      {required VoidCallback onTapConfirm}) {
    PanaraConfirmDialog.showAnimatedGrow(
      context,
      title: title,
      message: message,
      confirmButtonText: 'Yes',
      cancelButtonText: 'Cancel',

      onTapCancel: () {
        Navigator.pop(context);
      },
      onTapConfirm: onTapConfirm,
      panaraDialogType: PanaraDialogType.warning,
      barrierDismissible: false, // optional parameter (default is true)
    );
  }

  void showAlertDialog(
    BuildContext context,
    String title,
    String message,
  ) {
    PanaraInfoDialog.show(
      context,
      title: title,
      message: message,
      buttonText: 'Okay',
      onTapDismiss: () {
        Navigator.pop(context);
      },
      panaraDialogType: PanaraDialogType.normal,
      barrierDismissible: false, // optional parameter (default is true)
    );
  }
}
