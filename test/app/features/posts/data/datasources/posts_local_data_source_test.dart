import 'package:chirp/app/core/error/exceptions.dart';
import 'package:chirp/app/features/posts/data/datasources/posts_local_data_source.dart';
import 'package:chirp/app/features/posts/data/models/post_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:mocktail/mocktail.dart';

class MockHiveInterface extends Mock implements HiveInterface {}

class MockBox extends Mock implements Box {}

void main() {
  late PostsLocalDataSource dataSourceImpl;
  late MockHiveInterface mockHiveInterface;
  late MockBox mockHiveBox;

  final dateTime = DateTime(2021, 03, 23, 09, 24, 01);
  final tPosts = [
    PostModel(
      id: '0',
      authorName: 'Rodrigo Pequeno',
      published: dateTime,
      content: 'Olá',
    )
  ];

  setUp(() {
    mockHiveInterface = MockHiveInterface();
    mockHiveBox = MockBox();
    dataSourceImpl = PostsLocalDataSourceImpl(hive: mockHiveInterface);
  });

  group('getCachePosts', () {
    test('''should return Posts from Hive whe there in the cache''', () async {
      when(() => mockHiveInterface.openBox(any()))
          .thenAnswer((_) async => mockHiveBox);
      when(() => mockHiveBox.get(any())).thenReturn(tPosts);
      final result = await dataSourceImpl.getCachePosts();
      verify(() => mockHiveBox.get(kCachedPosts));
      expect(result, equals(tPosts));
    });

    test('''
should throw a NotFoundPostsCachedException when there is not a cached value''',
        () async {
      when(() => mockHiveInterface.openBox(any()))
          .thenAnswer((_) async => mockHiveBox);
      when(() => mockHiveBox.get(any)).thenReturn(null);
      final call = dataSourceImpl.getCachePosts();
      expect(call, throwsA(isA<NotFoundPostsCachedException>()));
    });
  });

  group('cachePosts', () {
    test('should call Hive to cache the data', () async {
      when(() => mockHiveInterface.openBox(any()))
          .thenAnswer((_) async => mockHiveBox);
      when(() => mockHiveBox.put(any(), any()))
          .thenAnswer((_) async => Future<void>.value());
      await dataSourceImpl.cachePosts(tPosts);
      verify(() => mockHiveInterface.openBox(kCachedPosts));
      verify(() => mockHiveBox.put(kCachedPosts, tPosts));
    });
  });

  group('getPosts', () {
    test('''should return saved Hive posts''', () async {
      when(() => mockHiveInterface.openBox(any()))
          .thenAnswer((_) async => mockHiveBox);
      when(() => mockHiveBox.get(any())).thenReturn(tPosts);
      final result = await dataSourceImpl.getCachePosts();
      verify(() => mockHiveBox.get(kCachedPosts));
      expect(result, equals(tPosts));
    });
  });

  group('putPosts', () {
    test('should call Hive to save the data', () async {
      when(() => mockHiveInterface.openBox(any()))
          .thenAnswer((_) async => mockHiveBox);
      when(() => mockHiveBox.put(any(), any()))
          .thenAnswer((_) async => Future<void>.value());
      await dataSourceImpl.cachePosts(tPosts);
      verify(() => mockHiveInterface.openBox(kCachedPosts));
      verify(() => mockHiveBox.put(kCachedPosts, tPosts));
    });
  });
}
