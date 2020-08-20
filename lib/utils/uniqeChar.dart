import 'dart:math';

Future<String> uniqueChar()async{

  final chars = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
  Random rnd = new Random(new DateTime.now().millisecondsSinceEpoch);
  String result = "";

  for (var i = 0; i < 20; i++) {
    result += chars[rnd.nextInt(chars.length)];
  }

  return result;
}