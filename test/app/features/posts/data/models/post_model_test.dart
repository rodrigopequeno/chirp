import 'dart:convert';

import 'package:chirp/app/features/posts/data/models/post_model.dart';
import 'package:chirp/app/features/posts/domain/entities/posts.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../../fixtures/fixture_reader.dart';

void main() {
  const content = 'Olá';
  const authorName = 'Rodrigo Pequeno';
  const id = '0';
  final dateTime = DateTime(2021, 03, 23, 09, 24, 01);
  final tPostModel = PostModel(
    id: id,
    authorName: authorName,
    content: content,
    published: dateTime,
  );

  test('should be a subclass of Post entity', () async {
    expect(tPostModel, isA<Post>());
  });

  group("fromJson", () {
    test('should return a valid model when from JSON', () async {
      final jsonMap = json.decode(fixture("post.json")) as Map<String, dynamic>;

      final result = PostModel.fromMap(jsonMap);

      expect(result, tPostModel);
    });
  });

  group("toJson", () {
    test('should return a JSON map containing the proper data', () async {
      final result = tPostModel.toMap();

      final expectedMap = {
        'ID': id,
        'AutorNome': authorName,
        'DataHora': dateTime.millisecondsSinceEpoch,
        'Texto': content,
      };

      expect(result, expectedMap);
    });
  });
}
