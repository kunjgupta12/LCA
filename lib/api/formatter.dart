import 'package:intl/intl.dart';

String formatTime(String timeString) {
  // Parse the time string
  DateTime time = DateTime.parse(timeString);

  // Format the time using the desired format
  return DateFormat('dd MMMM yyyy').format(time);
}
