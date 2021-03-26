import 'package:chirp/app/core/error/exceptions.dart';
import 'package:chirp/app/core/error/failure.dart';
import 'package:chirp/app/core/models/author_model.dart';
import 'package:chirp/app/core/models/post_model.dart';
import 'package:chirp/app/features/post_details/data/datasources/post_details_data_source.dart';
import 'package:chirp/app/features/post_details/data/repositories/post_details_repository_impl.dart';
import 'package:chirp/app/features/post_details/domain/repositories/post_details_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockPostDetailsDataSource extends Mock implements PostDetailsDataSource {}

void main() {
  late PostDetailsRepository repository;
  late MockPostDetailsDataSource mockPostDetailsDataSource;

  const tUid = "d34bcfff-aa6e-4a18-b817-64fde2e9ed6c";
  const tContent = "Hello";
  final tDateTime = DateTime(2021, 03, 23, 09, 24, 01);
  const tAuthor = AuthorModel(
      id: "75418de8-cf36-47c6-8850-3f958fb1b45d",
      authorName: "Rodrigo Pequeno",
      image: "https://randomuser.me/api/portraits/men/1.jpg");
  final tPost = PostModel(
    id: tUid,
    author: tAuthor,
    published: tDateTime,
    content: tContent,
  );

  setUp(() {
    mockPostDetailsDataSource = MockPostDetailsDataSource();
    repository =
        PostDetailsRepositoryImpl(detailsDataSource: mockPostDetailsDataSource);
  });

  group("deletePost", () {
    test(
        'should return data when the call to delete post data source is successful',
        () async {
      when(() => mockPostDetailsDataSource.deletePost(any()))
          .thenAnswer((_) async => {});
      final result = await repository.deletePost(tUid);
      verify(() => mockPostDetailsDataSource.deletePost(tUid));
      expect(result, equals(const Right(unit)));
    });
    test(
        'should return not found post failure when the call to delete post with unknown id',
        () async {
      when(() => mockPostDetailsDataSource.deletePost(any()))
          .thenThrow(NotFoundPostException());
      final result = await repository.deletePost(tUid);
      expect(result, equals(Left(NotFoundPostFailure())));
    });
    test(
        'should return delete post failure when the call to delete post data source is unsuccessful',
        () async {
      when(() => mockPostDetailsDataSource.deletePost(any()))
          .thenThrow(DeletePostException());
      final result = await repository.deletePost(tUid);
      expect(result, equals(Left(DeletePostFailure())));
    });
  });

  group("editPost", () {
    test(
        'should return data when the call to edit post data source is successful',
        () async {
      const newContent = "hello";
      when(() => mockPostDetailsDataSource.editPost(any(), any()))
          .thenAnswer((_) async => tPost);
      final result = await repository.editPost(tUid, newContent);
      verify(() => mockPostDetailsDataSource.editPost(tUid, newContent));
      expect(result, equals(Right(tPost)));
    });
    test(
        'should return not found post failure when the call to edit post with unknown id',
        () async {
      const newContent = "hello";
      when(() => mockPostDetailsDataSource.editPost(any(), any()))
          .thenThrow(NotFoundPostException());
      final result = await repository.editPost(tUid, newContent);
      expect(result, equals(Left(NotFoundPostFailure())));
    });
    test(
        'should return edit post failure when the call to edit post data source is unsuccessful',
        () async {
      const newContent = "hello";
      when(() => mockPostDetailsDataSource.editPost(any(), any()))
          .thenThrow(EditPostException());
      final result = await repository.editPost(tUid, newContent);
      expect(result, equals(Left(EditPostFailure())));
    });
  });
}
