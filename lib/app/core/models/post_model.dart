import 'dart:convert';

import 'package:chirp/app/core/entities/author.dart';
import 'package:chirp/app/core/entities/post.dart';
import 'package:hive/hive.dart';

import 'author_model.dart';

class PostModel extends Post {
  const PostModel(
      {required String id,
      required Author author,
      required DateTime published,
      required String content})
      : super(
          author: author,
          content: content,
          published: published,
          id: id,
        );

  PostModel copyWith({
    String? content,
  }) {
    return PostModel(
      id: id,
      author: author,
      published: published,
      content: content ?? this.content,
    );
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> postMap = {
      'ID': id,
      'DataHora': published.millisecondsSinceEpoch,
      'Texto': content,
    };
    return postMap..addAll((author as AuthorModel).toMap());
  }

  factory PostModel.fromMap(Map<String, dynamic> map) {
    return PostModel(
      author: AuthorModel.fromMap(map),
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
      author: fields[1] as AuthorModel,
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
      ..write(obj.author)
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
