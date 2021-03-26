import 'dart:convert';

import 'package:hive/hive.dart';

import '../entities/author.dart';

class AuthorModel extends Author {
  const AuthorModel(
      {required String id, required String authorName, String? image})
      : super(id: id, authorName: authorName, image: image);

  Map<String, dynamic> toMap() {
    return {
      'AutorID': id,
      'AutorNome': authorName,
      'AutorImageUrl': image,
    };
  }

  factory AuthorModel.fromMap(Map<String, dynamic> map) {
    return AuthorModel(
      id: map['AutorID'] as String,
      authorName: map['AutorNome'] as String,
      image: map['AutorImageUrl'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory AuthorModel.fromJson(String source) =>
      AuthorModel.fromMap(json.decode(source) as Map<String, dynamic>);
}

class AuthorModelAdapter extends TypeAdapter<AuthorModel> {
  @override
  final int typeId = 3;

  @override
  AuthorModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AuthorModel(
      id: fields[0] as String,
      authorName: fields[1] as String,
      image: fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, AuthorModel obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.authorName)
      ..writeByte(2)
      ..write(obj.image);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AuthorModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
