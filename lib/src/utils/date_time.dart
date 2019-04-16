import 'package:quiver/time.dart';

class FTimeUtils {
  FTimeUtils._();
}

class FLeftTime {
  final int days;
  final int hours;
  final int minutes;
  final int seconds;

  FLeftTime({
    this.days,
    this.hours,
    this.minutes,
    this.seconds,
  });

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

    final int hs = hours + days * 24;
    return _twoDigits(hs) +
        separator +
        _twoDigits(minutes) +
        separator +
        _twoDigits(seconds);
  }

  String tommss({String separator = ':'}) {
    assert(separator != null);

    final int ms = minutes + (hours * 60) + (days * 24 * 60);
    return _twoDigits(ms) + separator + _twoDigits(seconds);
  }
}
