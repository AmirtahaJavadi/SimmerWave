// models/radio_schema.dart
import 'package:hive_ce/hive.dart';

part 'radio_schema.g.dart';

@HiveType(typeId: 0)
class RadioSchema extends HiveObject {
  @HiveField(0) String id;
  @HiveField(1) String name;
  @HiveField(2 , defaultValue: '') String streamURL;
  @HiveField(3 , defaultValue: '') String imageURL;
  @HiveField(4 , defaultValue: '') String description;

  RadioSchema({required this.id, required this.name, required this.streamURL, required this.imageURL , required this.description});
}