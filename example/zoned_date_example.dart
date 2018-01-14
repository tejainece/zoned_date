import 'package:zoned_date/zoned_date.dart';

main() {
  print(new ZonedDate.convertZone(new DateTime.now(), Timezone.est));
  print(new ZonedDate(Timezone.est));
  print(new ZonedDate());

  final time = new ZonedDate.make(2018,
      month: 1, day: 14, hour: 1, minute: 15, zone: Timezone.est);
  print(time.add(new Duration(hours: 1)));
}
