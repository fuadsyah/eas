import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'dart:io';

import './uniqeChar.dart';

Future<File> compressImage(File file) async {
  var path;

  await uniqueChar().then((char){
    path = char;
  });

  final dir = await path_provider.getTemporaryDirectory();
  final targetPath = dir.absolute.path + "/$path.jpg";

  var result = await FlutterImageCompress.compressAndGetFile(
    file.absolute.path, targetPath,
    quality: 88,
    minWidth: 200,
    minHeight: 200,
  );

  print(file.lengthSync());
  print(result.lengthSync());


  return result;
}