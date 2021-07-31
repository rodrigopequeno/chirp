import 'package:core/error/exceptions.dart';
import 'package:core/models/author_model.dart';
import 'package:core/models/post_model.dart';
import 'package:post_details/data/datasources/post_details_data_source.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:mocktail/mocktail.dart';

class MockHiveInterface extends Mock implements HiveInterface {}

class MockBox extends Mock implements Box {}

void main() {
  late MockHiveInterface mockHiveInterface;
  late MockBox mockHiveBox;
  late PostDetailsDataSource postDetailsDataSource;

  const tUid = "d34bcfff-aa6e-4a18-b817-64fde2e9ed6c";
  const tContent = "Hello";
  final tDateTime = DateTime(2021, 03, 23, 09, 24, 01);
  const tAuthor = AuthorModel(
      id: "75418de8-cf36-47c6-8850-3f958fb1b45d",
      authorName: "Rodrigo Pequeno",
      image: "https://randomuser.me/api/portraits/men/1.jpg");
  final tPosts = [
    PostModel(
      id: tUid,
      author: tAuthor,
      published: tDateTime,
      content: tContent,
    ),
    PostModel(
      id: "other",
      author: tAuthor,
      published: tDateTime,
      content: tContent,
    )
  ];

  setUpAll(() {
    mockHiveInterface = MockHiveInterface();
    mockHiveBox = MockBox();
    postDetailsDataSource = PostDetailsDataSourceImpl(mockHiveInterface);
    when(() => mockHiveInterface.openBox(any<String>()))
        .thenAnswer((_) async => mockHiveBox);
  });

  group("editPost", () {
    test('should edit the post', () async {
      const tNewContent = "Hello new";
      when(() => mockHiveBox.get(any<String>(),
          defaultValue: any(named: 'defaultValue'))).thenReturn(tPosts);
      when(() => mockHiveBox.put(any(), any())).thenAnswer((_) async => {});
      final result = await postDetailsDataSource.editPost(tUid, tNewContent);
      expect(result.content, equals(tNewContent));
    });

    test('should return NotFoundPostException when no post is found with uid',
        () async {
      const tNewContent = "Hello new";
      when(() => mockHiveBox.get(any<String>(),
          defaultValue: any(named: 'defaultValue'))).thenReturn(tPosts);
      when(() => mockHiveBox.put(any(), any())).thenAnswer((_) async => {});

      expect(() => postDetailsDataSource.editPost("", tNewContent),
          throwsA(isA<NotFoundPostException>()));
    });

    test(
        'should return EditPostException when an error occurred while trying to save the content',
        () async {
      const tNewContent = "Hello new";
      when(() => mockHiveBox.get(any<String>(),
          defaultValue: any(named: 'defaultValue'))).thenReturn(tPosts);
      when(() => mockHiveBox.put(any(), any())).thenThrow(Exception());

      expect(() => postDetailsDataSource.editPost(tUid, tNewContent),
          throwsA(isA<EditPostException>()));
    });
  });

  group("deletePost", () {
    test('should delete a post', () async {
      when(() => mockHiveBox.get(any<String>(),
          defaultValue: any(named: 'defaultValue'))).thenReturn(tPosts);
      when(() => mockHiveBox.put(any(), any())).thenAnswer((_) async => {});
      expect(postDetailsDataSource.deletePost(tUid), completes);
    });

    test('should return NotFoundPostException when no post is found with uid',
        () async {
      when(() => mockHiveBox.get(any<String>(),
          defaultValue: any(named: 'defaultValue'))).thenReturn(tPosts);
      when(() => mockHiveBox.put(any(), any())).thenAnswer((_) async => {});

      expect(() => postDetailsDataSource.deletePost(""),
          throwsA(isA<NotFoundPostException>()));
    });

    test(
        'should return DeletePostException when an error occurred while trying to delete the post',
        () async {
      when(() => mockHiveBox.get(any<String>(),
          defaultValue: any(named: 'defaultValue'))).thenReturn(tPosts);
      when(() => mockHiveBox.put(any(), any())).thenThrow(Exception());

      expect(() => postDetailsDataSource.deletePost(tUid),
          throwsA(isA<DeletePostException>()));
    });
  });
}
