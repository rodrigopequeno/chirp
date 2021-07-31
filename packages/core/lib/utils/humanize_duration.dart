import 'package:intl/intl.dart';

class Humanize {
  String differenceDateTimeNow(DateTime dateTime) {
    final duration = DateTime.now().difference(dateTime);
    const int minute = 60;
    const int hour = 3600;
    const int day = 86400;
    final double delta = duration.inSeconds.toDouble().abs();

    if (delta < 1 * minute) return "just now";
    if (delta < 2 * minute) return "minute ago";
    if (delta < 45 * minute) return "${duration.inMinutes} minutes ago";
    if (delta < 90 * minute) return "hour ago";
    if (delta < 24 * hour) return "${duration.inHours} hours ago";
    if (delta < 48 * hour) return "yesterday";
    if (delta < 30 * day) return "${duration.inDays} days ago";
    return DateFormat("dd/MM/yyyy").format(dateTime);
  }
}
