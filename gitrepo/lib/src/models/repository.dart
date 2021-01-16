import 'dart:convert';
import 'package:gitrepo/src/models/tag.dart';
import 'package:hive/hive.dart';
part 'repository.g.dart';

List<Repository> repositoryFromJson(List<dynamic> list) =>
    List<Repository>.from(
        list.map((repository) => Repository.fromJson(repository)));

String repositoryToJson(List<Repository> repositories) => json.encode(
    List<dynamic>.from(repositories.map((repository) => repository.toJson())));

@HiveType(typeId: 1)
class Repositories {
  Repositories({this.repositories});

  @HiveField(0)
  List<Repository> repositories;

  factory Repositories.fromJson(List<dynamic> listRepositories) =>
      Repositories(repositories: repositoryFromJson(listRepositories));

  Map<String, dynamic> toJson() =>
      {"repositories": this.repositories.map((e) => e.toJson()).toList()};

  factory Repositories.empty() => Repositories(repositories: []);
}

@HiveType(typeId: 2)
class Repository {
  Repository({
    this.id,
    this.name,
    this.private,
    this.htmlUrl,
    this.description,
    this.language,
    this.tag,
  });

  @HiveField(0)
  int id;
  @HiveField(1)
  String name;
  @HiveField(2)
  bool private;
  @HiveField(3)
  String htmlUrl;
  @HiveField(4)
  String description;
  @HiveField(5)
  String language;
  @HiveField(6)
  Tag tag;

  factory Repository.fromJson(Map<String, dynamic> json) => Repository(
      id: json["id"],
      name: json["name"],
      private: json["private"],
      htmlUrl: json["html_url"],
      description: json["description"],
      language: json["language"],
      tag: json["tags"]);

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "private": private,
        "html_url": htmlUrl,
        "description": description,
        "language": language,
        "tags": tag,
      };
}
