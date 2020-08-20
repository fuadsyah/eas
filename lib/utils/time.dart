import 'package:intl/intl.dart';


Future<String> getTime() async{
  final DateTime now = DateTime.now();
  final String formattedDateTime = formatClock(now);

  return formattedDateTime;
}

String formatClock(DateTime dateTime){
  var day = DateFormat('EEEE').format(dateTime);
  var indoDay = convertDay(day);

  var date =  DateFormat('dd, yyyy \nHH:mm:ss').format(dateTime);
  return ('$indoDay $date');
}

final dateFormat = DateFormat("yyyy-MM-dd");

final dateTimeFormat = DateFormat("yyyy-MM-dd HH:mm:ss");

convertDay(day){
  switch(day){
    case 'Sunday':
      return 'Minggu';
      break;
    case 'Monday':
      return 'Senin';
      break;
    case 'Tuesday':
      return 'Selasa';
      break;
    case 'Wednesday':
      return 'Rabu';
      break;
    case 'Thursday':
      return 'Kamis';
      break;
    case 'Friday':
      return 'Jumat';
      break;
    case 'Saturday':
      return 'Sabtu';
      break;
  }
}