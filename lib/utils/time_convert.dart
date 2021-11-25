String convertTime(String timeString) {
  DateTime dateTime = DateTime.parse(timeString);
  var diff = DateTime.now().difference(dateTime);
  if (diff.inDays > 0) {
    var month = diff.inDays / 30;
    if (month > 0) {
      return month > 12 ? '${month / 12} years' : '${month.toInt()} month';
    } else {
      return '${diff.inDays} days';
    }
  } else {
    if (diff.inHours > 0) {
      return '${diff.inHours} hours';
    } else {
      return '${diff.inMinutes} minutes';
    }
  }
}
