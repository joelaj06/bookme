import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';

class Base64Convertor {
  static bool isFolderCreated = false;
  static Directory? directory;

  static Future<double> checkImageSize(XFile? imageFile) async{
    final int? bytes = (await imageFile?.readAsBytes())?.lengthInBytes;
    if (bytes != null) {
      final double imageInKb = bytes / 1024;
      final double imageInMB = imageInKb / 1024;
      return imageInMB;
    }
    return 0;
  }

  static Future<void> checkDocumentFolder() async {
    try {
      if (!isFolderCreated) {
        directory = await getApplicationDocumentsDirectory();
        // ignore: avoid_slow_async_io
        final bool value = await directory!.exists();
        if (value) {
          await directory!.create();
        }
        isFolderCreated = true;
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  static Future<File> downloadPdfFile(String base64PdfString) async {
    final String base64str = base64PdfString;
    final Uint8List bytes = base64.decode(base64str);
    await checkDocumentFolder();
    final String dir =
        '${directory!.path}/${DateTime.now().millisecondsSinceEpoch}.pdf';
    final File file = File(dir);
    if (!file.existsSync()) {
      await file.create();
    }
    await file.writeAsBytes(bytes);
    return file;
  }

  static Future<void> openPdfFile(String fileName) async {
    final String dir = '${directory!.path}/$fileName';
    await OpenFile.open(dir);
  }

  Uint8List base64toImage(String base64String) {
    final String base64 = base64String.contains(',') ?
    base64String.split(',')[1] : base64String;
    final Uint8List bytes = const Base64Decoder().convert(base64);
    return bytes;
  }

  String imageToBase64(String imagePath) {
    final Uint8List bytes = File(imagePath).readAsBytesSync();
    final String base64Image = 'data:image/png;base64,${base64Encode(bytes)}';
    return base64Image;
  }

}
