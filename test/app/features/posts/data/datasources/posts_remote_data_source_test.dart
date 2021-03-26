import 'dart:convert';

import 'package:chirp/app/core/error/exceptions.dart';
import 'package:chirp/app/core/models/post_model.dart';
import 'package:chirp/app/features/posts/data/datasources/posts_remote_data_source.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../../fixtures/fixture_reader.dart';

class MockDio extends Mock implements Dio {}

void main() {
  late PostsRemoteDataSource dataSourceImpl;
  late Dio mockClient;

  setUp(() {
    mockClient = MockDio();
    dataSourceImpl = PostsRemoteDataSourceImpl(client: mockClient);
  });

  void setUpMockClientSuccess200() {
    when(() => mockClient.get(any())).thenAnswer(
      (_) async => Response(
          requestOptions: RequestOptions(path: ''),
          data: json.decode(fixture('posts.json')),
          statusCode: 200),
    );
  }

  void setupUpMockClientFailure404() {
    when(() => mockClient.get(any())).thenAnswer(
      (_) async => Response(
          requestOptions: RequestOptions(path: ''),
          data: 'Something went wrong',
          statusCode: 404),
    );
  }

  group('getAllPost', () {
    final tPosts = List<PostModel>.from(((json.decode(fixture('posts.json'))
            as Map<String, dynamic>)['Result'] as List)
        .map((e) => PostModel.fromMap(e as Map<String, dynamic>))
        .toList());
    test('should perform a GET request on a URL to get all posts', () async {
      setUpMockClientSuccess200();
      dataSourceImpl.getAllPosts();
      verify(
        () => mockClient.get('https://api.mocki.io/v1/f932124c/posts'),
      );
    });

    test('should return Post when the response code is 200 (success)',
        () async {
      setUpMockClientSuccess200();
      final result = await dataSourceImpl.getAllPosts();
      expect(result, equals(tPosts));
    });

    test(
        'should throw a ServerException when the response code is 404 or other',
        () async {
      setupUpMockClientFailure404();
      final call = dataSourceImpl.getAllPosts;
      expect(() => call(), throwsA(isA<ServerException>()));
    });
  });
}
