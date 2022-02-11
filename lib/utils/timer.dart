/// 时间戳转时间
String getDate(int value) {
  String valueString = value.toString().substring(0, 13);
  int valueInt = int.parse(valueString);

  DateTime valueTime = DateTime.fromMillisecondsSinceEpoch(valueInt);
  DateTime now = DateTime.now();
  Duration cha = now.difference(valueTime);

  String month =
      valueTime.month < 10 ? '0${valueTime.month}' : '${valueTime.month}';
  String day = valueTime.day < 10 ? '0${valueTime.day}' : '${valueTime.day}';

  if (now.year > valueTime.year) {
    return '${valueTime.year}-$month-$day';
  } else if (cha.inDays > 30) {
    return '${cha.inDays ~/ 30} 月前';
  } else if (cha.inHours > 24) {
    return '${cha.inHours ~/ 24} 天前';
  } else if (cha.inMinutes > 60) {
    return '${cha.inMinutes ~/ 60} 分钟前';
  } else if (cha.inMinutes > 5) {
    return '${cha.inMinutes} 分钟前';
  } else {
    return '刚刚';
  }
}

/// 时间格式化
///
/// 把秒数转成：00:00:00的格式
String getDuration(int value) {
  // 初始化
  // 首先默认所有的时间都是 0
  int minute = 0;
  int second = 0;
  int hour = 0;

  // 第一步是看分钟的数量
  minute = value ~/ 60;
  second = value % 60;
  String secondString = second < 10 ? '0$second' : '$second';

  if (minute < 10) {
    return '0$minute:$secondString';
  } else if (minute < 60) {
    return '$minute:$secondString';
  } else {
    hour = minute ~/ 60;
    minute = minute % 60;
    String hourString = hour < 10 ? '0$hour' : '$hour';
    String minuteString = minute < 10 ? '0$minute' : '$minute';
    return '$hourString:$minuteString:$secondString';
  }
}
