library zonedtime;

import 'package:date_format/date_format.dart';

part 'time_zone.dart';

class ZonedDate implements DateTime {
  final int year;
  final int month;
  final int day;
  final int hour;
  final int minute;
  final int second;
  final int millisecond;
  final int microsecond;

  final Timezone _zone;

  DateTime _utc;

  factory ZonedDate([Timezone zone]) {
    zone ??= Timezone.local;
    return new ZonedDate.convertZone(new DateTime.now(), zone);
    ;
  }

  factory ZonedDate.from(DateTime date) {
    Timezone zone =
        Timezone.zones[date.timeZoneName] ??= new Timezone(date.timeZoneOffset);

    return new ZonedDate.make(
      date.year,
      month: date.month,
      day: date.day,
      hour: date.hour,
      minute: date.minute,
      second: date.second,
      millisecond: date.millisecond,
      microsecond: date.microsecond,
      zone: zone,
    );
  }

  ZonedDate.utc(DateTime utc)
      : _zone = Timezone.utc,
        year = utc.year,
        month = utc.month,
        day = utc.day,
        hour = utc.hour,
        minute = utc.minute,
        second = utc.second,
        millisecond = utc.millisecond,
        microsecond = utc.microsecond {
    if (!utc.isUtc)
      throw new ArgumentError.value(utc, 'utc', 'UTC time expected!');

    _utc = utc;
  }

  factory ZonedDate.asZone(DateTime date, Timezone zone) => new ZonedDate.make(
        date.year,
        month: date.month,
        day: date.day,
        hour: date.hour,
        minute: date.minute,
        second: date.second,
        millisecond: date.millisecond,
        microsecond: date.microsecond,
        zone: zone,
      );

  factory ZonedDate.convertZone(DateTime zoned, Timezone zone) {
    if (zoned.timeZoneOffset == zone.offset)
      return new ZonedDate.asZone(zoned, zone);

    final Duration diff = zone.offset - zoned.timeZoneOffset;
    return new ZonedDate.asZone(zoned.add(diff), zone);
  }

  ZonedDate.make(this.year,
      {this.month = 1,
      this.day = 1,
      this.hour = 0,
      this.minute = 0,
      this.second = 0,
      this.millisecond = 0,
      this.microsecond = 0,
      Timezone zone})
      : _zone = zone ?? Timezone.utc {
    if (_zone.offset.inMicroseconds == 0) {
      _utc = new DateTime.utc(
          year, month, day, hour, minute, second, millisecond, microsecond);
    } else {
      _utc = new DateTime.utc(
              year, month, day, hour, minute, second, millisecond, microsecond)
          .subtract(zone.offset);
    }
  }

  Timezone get zone => _zone;

  String get timeZoneName => zone.name;

  Duration get timeZoneOffset => zone.offset;

  bool operator ==(other) {
    if (other is ZonedDate) {
      return year == other.year &&
          month == other.month &&
          day == other.day &&
          hour == other.hour &&
          minute == other.minute &&
          second == other.second &&
          millisecond == other.millisecond &&
          microsecond == other.microsecond;
    } else {
      return false;
    }
  }

  bool isBefore(DateTime other) => _utc.isBefore(other);

  bool isAfter(DateTime other) => _utc.isAfter(other);

  bool isAtSameMomentAs(DateTime other) => _utc.isAtSameMomentAs(other);

  int compareTo(DateTime other) => _utc.compareTo(other);

  int get hashCode => _utc.hashCode;

  ZonedDate toLocal() => new ZonedDate.convertZone(this, Timezone.local);

  ZonedDate toUtc() => new ZonedDate.from(_utc);

  ZonedDate toUtcDateTime() => _utc;

  String toString() => formatDate(this,
      [yyyy, '-', mm, '-', dd, 'T', HH, ':', nn, ':', ss, '.', SSS, ' ', z]);

  String toIso8601String() => formatDate(this, [
        yyyy,
        '-',
        mm,
        '-',
        dd,
        'T',
        HH,
        ':',
        nn,
        ':',
        ss,
        '.',
        SSS,
        uuu,
        ' ',
        z
      ]);

  ZonedDate add(Duration duration) =>
      new ZonedDate.convertZone(_utc.add(duration), zone);

  ZonedDate subtract(Duration duration) =>
      new ZonedDate.convertZone(_utc.subtract(duration), zone);

  Duration difference(DateTime other) => _utc.difference(other);

  int get millisecondsSinceEpoch => _utc.millisecondsSinceEpoch;

  int get microsecondsSinceEpoch => _utc.microsecondsSinceEpoch;

  int get weekday => new DateTime.utc(year, month, day).weekday;

  bool get isUtc => zone.offset.inMicroseconds == 0;
}
