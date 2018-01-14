import 'package:zoned_date/zoned_date.dart';
import 'package:test/test.dart';

void main() {
  group('ZonedTime', () {
    final t1 = new ZonedDate.make(2018,
        month: 1, day: 14, hour: 1, minute: 15, zone: Timezone.est);

    setUp(() {
    });

    test('add', () {
      final ZonedDate tr = t1.add(new Duration(hours: 1));
      expect(tr.year, 2018);
      expect(tr.month, 1);
      expect(tr.day, 14);
      expect(tr.hour, 2);
      expect(tr.minute, 15);
      expect(tr.second, 0);
      expect(tr.millisecond, 0);
      expect(tr.microsecond, 0);
      expect(tr.zone, t1.zone);
    });

    test('subtract', () {
      final ZonedDate tr = t1.subtract(new Duration(hours: 1));
      expect(tr.year, 2018);
      expect(tr.month, 1);
      expect(tr.day, 14);
      expect(tr.hour, 0);
      expect(tr.minute, 15);
      expect(tr.second, 0);
      expect(tr.millisecond, 0);
      expect(tr.microsecond, 0);
      expect(tr.zone, t1.zone);
    });
  });
}
