part of zonedtime;

class Timezone {
  final String name;

  final Duration offset;

  const Timezone(this.offset, [this.name = '']);

  bool operator ==(other) {
    if (other is Timezone) {
      return other.offset == offset;
    } else {
      return false;
    }
  }

  static final Timezone local = zones[new DateTime.now().timeZoneName] ??
      new Timezone(new DateTime.now().timeZoneOffset);

  static const Timezone est = const Timezone(const Duration(hours: -5), 'EST');
  static const Timezone utc = const Timezone(const Duration(), 'UTC');
  static const Timezone cet = const Timezone(const Duration(hours: 1), 'CET');

  static const Map<String, Timezone> zones = const <String, Timezone>{
    'UTC': utc,
    'CET': cet,
    'EST': est,
  };
}
