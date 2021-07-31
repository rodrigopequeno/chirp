import 'package:core/entities/author.dart';
import 'package:core/models/post_model.dart';
import 'package:add_post/data/datasources/add_post_data_source.dart';
import 'package:add_post/data/repositories/add_post_repository_impl.dart';
import 'package:add_post/domain/repositories/add_post_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAddPostDataSource extends Mock implements AddPostDataSource {}

void main() {
  late AddPostRepository repository;
  late MockAddPostDataSource mockAddPostDataSource;

  setUp(() {
    mockAddPostDataSource = MockAddPostDataSource();
    repository =
        AddPostRepositoryImpl(addPostDataSource: mockAddPostDataSource);
  });
  const author = Author(
      id: "75418de8-cf36-47c6-8850-3f958fb1b45d",
      authorName: "Rodrigo Pequeno");
  final tPost = PostModel(
    id: '0',
    author: author,
    content: "Seja bem vindo",
    published: DateTime.now(),
  );

  setUpAll(() {
    registerFallbackValue<PostModel>(tPost);
  });

  group("createPost", () {
    test('should create post', () async {
      when(() => mockAddPostDataSource.createPost(any()))
          .thenAnswer((_) async {});
      final result = await repository.addPost(tPost);
      verify(() => mockAddPostDataSource.createPost(tPost));
      expect(result, equals(const Right(unit)));
    });
  });
}
