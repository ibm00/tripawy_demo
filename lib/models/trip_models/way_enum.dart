import 'package:hive/hive.dart';

part 'way_enum.g.dart';

@HiveType(typeId: 4)
enum Way {
  @HiveField(0)
  OneWay,

  @HiveField(1)
  Round,
}

//last used typId is 6