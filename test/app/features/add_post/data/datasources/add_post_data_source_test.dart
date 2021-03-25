import 'package:chirp/app/features/add_post/data/datasources/add_post_data_source.dart';
import 'package:chirp/app/features/add_post/data/models/add_post_model.dart';
import 'package:chirp/app/features/add_post/domain/entities/add_author.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:mocktail/mocktail.dart';

class MockHiveInterface extends Mock implements HiveInterface {}

class MockBox extends Mock implements Box {}

void main() {
  late MockHiveInterface mockHiveInterface;
  late MockBox mockHiveBox;
  late AddPostDataSource addPostDataSource;

  setUpAll(() {
    mockHiveInterface = MockHiveInterface();
    mockHiveBox = MockBox();
    addPostDataSource = AddPostDataSourceImpl(mockHiveInterface);
    when(() => mockHiveInterface.openBox(any<String>()))
        .thenAnswer((_) async => mockHiveBox);
  });

  const author = AddAuthor(
      id: "75418de8-cf36-47c6-8850-3f958fb1b45d",
      authorName: "Rodrigo Pequeno");
  final tPost = AddPostModel(
    id: '0',
    author: author,
    content: "Seja bem vindo",
    published: DateTime.now(),
  );

  group("createPost", () {
    test('should create post', () async {
      when(() => mockHiveBox.put(any(), any())).thenAnswer((_) async => {});
      when(() =>
              mockHiveBox.get(any(), defaultValue: any(named: 'defaultValue')))
          .thenReturn([tPost]);
      expect(addPostDataSource.createPost(tPost), completes);
    });
  });
}
