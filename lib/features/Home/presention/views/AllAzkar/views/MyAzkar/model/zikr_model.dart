import 'package:hive/hive.dart';

part 'zikr_model.g.dart';

@HiveType(typeId: 1)
class ZikrModel extends HiveObject {
  @HiveField(0)
  final String title;

  @HiveField(1)
  final String content;

  @HiveField(2)
  final int count;

  ZikrModel({
    required this.title,
    required this.content,
    required this.count,
  });
}
