class Level {
  static const BEGINNER = Level("BEGINNER");
  static const MEDIUM = Level("MEDIUM");
  static const ADVANCED = Level("ADVANCED");

  final String name;

  const Level(this.name);

  @override
  String toString() {
    return name;
  }

  static const List<Level> LIST = <Level>[BEGINNER, MEDIUM, ADVANCED];
}

