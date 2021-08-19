import 'package:hive/hive.dart';

part 'repeat_enum.g.dart';

@HiveType(typeId: 5)
enum Repeating {
  @HiveField(0)
  No,

  @HiveField(1)
  Daily,

  @HiveField(2)
  Weekly,

  @HiveField(3)
  Monthly,
}

// 3 & 100 id is used
