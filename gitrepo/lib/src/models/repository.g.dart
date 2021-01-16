// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'repository.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class RepositoriesAdapter extends TypeAdapter<Repositories> {
  @override
  final int typeId = 1;

  @override
  Repositories read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Repositories(
      repositories: (fields[0] as List)?.cast<Repository>(),
    );
  }

  @override
  void write(BinaryWriter writer, Repositories obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.repositories);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RepositoriesAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class RepositoryAdapter extends TypeAdapter<Repository> {
  @override
  final int typeId = 2;

  @override
  Repository read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Repository(
      id: fields[0] as int,
      name: fields[1] as String,
      private: fields[2] as bool,
      htmlUrl: fields[3] as String,
      description: fields[4] as String,
      language: fields[5] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Repository obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.private)
      ..writeByte(3)
      ..write(obj.htmlUrl)
      ..writeByte(4)
      ..write(obj.description)
      ..writeByte(5)
      ..write(obj.language);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RepositoryAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
