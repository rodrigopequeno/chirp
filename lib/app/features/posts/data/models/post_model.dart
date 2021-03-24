import 'dart:convert';

import 'package:hive/hive.dart';

import '../../domain/entities/posts.dart';

class PostModel extends Post {
  const PostModel(
      {required String id,
      required String authorName,
      required DateTime published,
      required String content})
      : super(
          authorName: authorName,
          content: content,
          published: published,
          id: id,
        );

  Map<String, dynamic> toMap() {
    return {
      'ID': id,
      'AutorNome': authorName,
      'DataHora': published.millisecondsSinceEpoch,
      'Texto': content,
    };
  }

  factory PostModel.fromMap(Map<String, dynamic> map) {
    return PostModel(
      authorName: map['AutorNome'] as String,
      published: DateTime.fromMillisecondsSinceEpoch(
        int.tryParse(map['DataHora'] as String) ?? 0,
      ),
      content: map['Texto'] as String,
      id: map['ID'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory PostModel.fromJson(String source) =>
      PostModel.fromMap(json.decode(source) as Map<String, dynamic>);
}

class PostModelAdapter extends TypeAdapter<PostModel> {
  @override
  final int typeId = 1;

  @override
  PostModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PostModel(
      id: fields[0] as String,
      authorName: fields[1] as String,
      content: fields[2] as String,
      published: fields[3] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, PostModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.authorName)
      ..writeByte(2)
      ..write(obj.content)
      ..writeByte(3)
      ..write(obj.published);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PostModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
