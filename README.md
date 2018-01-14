# zoned_date

DateTime with timezones.

# Usage

## Create

### Interpret DateTime as different zone

Interpret year, month, day, hour, minute, second, millisecond and microsecond with different time zone.

```dart
// Interpret 2018.1.14T17:32 in EST timezone
final time = new ZonedDate.asZone(new DateTime(2018, 1, 14, 17, 32), Timezone.est);
```

### Convert to different zone

```dart
// Convert local current time to EST
final time = new ZonedDate.convertZone(new DateTime.now(), Timezone.est);
```

### Current time at different timezone

```dart
// Convert local current time to EST
final time = new ZonedDate(Timezone.est);
```