import 'package:chirp/app/core/entities/author.dart';
import 'package:chirp/app/features/add_post/data/models/add_author_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const tAddAuthorModel = AddAuthorModel(id: '0', authorName: "Rodrigo");

  test('should be a subclass of Author entity', () async {
    expect(tAddAuthorModel, isA<Author>());
  });
}
