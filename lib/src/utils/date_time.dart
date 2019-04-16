import 'package:quiver/time.dart';

class FTimeUtils {
  FTimeUtils._();
}

class FLeftTime {
  final int days;
  final int hours;
  final int minutes;
  final int seconds;

  final Duration duration;

  FLeftTime({
    this.days,
    this.hours,
    this.minutes,
    this.seconds,
  }) : this.duration = Duration(
          days: days,
          hours: hours,
          minutes: minutes,
          seconds: seconds,
        );

  factory FLeftTime.parse(int milliSeconds) {
    final int day = milliSeconds ~/ aDay.inMilliseconds;
    final int dayLeft = milliSeconds % aDay.inMilliseconds;

    final int hour = dayLeft ~/ anHour.inMilliseconds;
    final int hourLeft = dayLeft % anHour.inMilliseconds;

    final int minute = hourLeft ~/ aMinute.inMilliseconds;
    final int minuteLeft = hourLeft % aMinute.inMilliseconds;

    final int second = minuteLeft ~/ aSecond.inMilliseconds;

    return FLeftTime(
      days: day,
      hours: hour,
      minutes: minute,
      seconds: second,
    );
  }

  static String _twoDigits(int n) {
    if (n >= 10) return "${n}";
    return "0${n}";
  }

  String toHHmmss({String separator = ':'}) {
    assert(separator != null);

    final int h = duration.inHours;
    if (h > 0) {
      final StringBuffer buffer = new StringBuffer();
      buffer.write(_twoDigits(h));
      buffer.write(separator);
      buffer.write(_twoDigits(minutes));
      buffer.write(separator);
      buffer.write(_twoDigits(seconds));
      return buffer.toString();
    } else {
      return tommss(separator: separator);
    }
  }

  String tommss({String separator = ':'}) {
    assert(separator != null);

    final StringBuffer buffer = new StringBuffer();
    buffer.write(_twoDigits(duration.inMinutes));
    buffer.write(separator);
    buffer.write(_twoDigits(seconds));
    return buffer.toString();
  }
}
