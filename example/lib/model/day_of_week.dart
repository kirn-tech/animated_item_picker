class DayOfWeek {
  static const MONDAY = DayOfWeek._(name: 'MONDAY');
  static const TUESDAY = DayOfWeek._(name: 'TUESDAY');
  static const WEDNESDAY = DayOfWeek._(name: 'WEDNESDAY');
  static const THURSDAY = DayOfWeek._(name: 'THURSDAY');
  static const FRIDAY = DayOfWeek._(name: 'FRIDAY');
  static const SATURDAY = DayOfWeek._(name: 'SATURDAY');
  static const SUNDAY = DayOfWeek._(name: 'SUNDAY');

  static const LIST = const [MONDAY, TUESDAY, WEDNESDAY, THURSDAY, FRIDAY, SATURDAY, SUNDAY];

  final String name;

  int index() => LIST.indexOf(this);

  const DayOfWeek._({required this.name});
}
