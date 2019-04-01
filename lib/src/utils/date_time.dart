import 'package:quiver/time.dart';

class FTimeUtils {
  FTimeUtils._();

  /// 格式化剩余时间
  static LeftTimeModel formatDuration(int milliSecond) {
    final int day = milliSecond ~/ aDay.inMilliseconds;
    final int dayLeft = milliSecond % aDay.inMilliseconds;

    final int hour = dayLeft ~/ anHour.inMilliseconds;
    final int hourLeft = dayLeft % anHour.inMilliseconds;

    final int minute = hourLeft ~/ aMinute.inMilliseconds;
    final int minuteLeft = hourLeft % aMinute.inMilliseconds;

    final int second = minuteLeft ~/ aSecond.inMilliseconds;

    return LeftTimeModel(
      days: day,
      hours: hour,
      minutes: minute,
      seconds: second,
    );
  }
}

class LeftTimeModel {
  final int days;
  final int hours;
  final int minutes;
  final int seconds;

  LeftTimeModel({
    this.days,
    this.hours,
    this.minutes,
    this.seconds,
  });
}
