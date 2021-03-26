import 'dart:convert';

import 'package:chirp/app/core/entities/post.dart';
import 'package:chirp/app/core/models/author_model.dart';
import 'package:chirp/app/core/models/post_model.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../../fixtures/fixture_reader.dart';

void main() {
  const tContent = 'Hello';
  const tAuthorName = 'Rodrigo Pequeno';
  const tId = '2e9bf094-e494-4e22-ba10-dcf07ebfd18d';
  const tImage = "https://randomuser.me/api/portraits/men/1.jpg";
  final tDateTime = DateTime(2021, 03, 23, 09, 24, 01);
  const tAuthor = AuthorModel(
      id: "75418de8-cf36-47c6-8850-3f958fb1b45d",
      authorName: tAuthorName,
      image: tImage);
  final tPostModel = PostModel(
    id: tId,
    author: tAuthor,
    content: tContent,
    published: tDateTime,
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
        'ID': tId,
        "AutorID": tAuthor.id,
        "AutorNome": tAuthor.authorName,
        'DataHora': tDateTime.millisecondsSinceEpoch,
        'Texto': tContent,
        'AutorImageUrl': tAuthor.image
      };

      expect(result, expectedMap);
    });
  });
}
