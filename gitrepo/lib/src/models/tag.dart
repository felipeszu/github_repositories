import 'package:hive/hive.dart';
part 'tag.g.dart';

@HiveType(typeId: 3)
class Tag {
  Tag({
    this.idRepository,
    this.tags,
  });

  @HiveField(0)
  int idRepository;
  @HiveField(1)
  List<String> tags;

  factory Tag.fromJson(Map<String, dynamic> json) => Tag(
        idRepository: json["idRepository"],
        tags: json["tags"],
      );
}
