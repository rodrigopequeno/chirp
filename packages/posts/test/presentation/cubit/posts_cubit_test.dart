import 'package:bloc_test/bloc_test.dart';
import 'package:core/error/failure.dart';
import 'package:core/models/author_model.dart';
import 'package:core/models/post_model.dart';
import 'package:core/usecases/no_params.dart';
import 'package:posts/domain/usecases/get_all_posts.dart';
import 'package:posts/presentation/cubit/posts_cubit.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockGetAllPosts extends Mock implements GetAllPosts {}

void main() {
  late PostsCubit cubit;
  late MockGetAllPosts mockGetAllPosts;

  final tDateTime = DateTime(2021, 03, 23, 09, 24, 01);
  const tAuthor = AuthorModel(
      id: "75418de8-cf36-47c6-8850-3f958fb1b45d",
      authorName: "Rodrigo Pequeno",
      image: "https://randomuser.me/api/portraits/men/1.jpg");
  final tPosts = [
    PostModel(
      id: '2e9bf094-e494-4e22-ba10-dcf07ebfd18d',
      author: tAuthor,
      published: tDateTime,
      content: 'Hello',
    )
  ];

  setUpAll(() {
    registerFallbackValue<NoParams>(const NoParams());
  });

  setUp(() {
    mockGetAllPosts = MockGetAllPosts();

    cubit = PostsCubit(mockGetAllPosts);
  });

  tearDown(() {
    cubit.close();
  });

  test('initialState should be PostsInitial', () async {
    expect(cubit.state, isA<PostsInitial>());
  });

  group('getPosts', () {
    blocTest<PostsCubit, PostsState>(
      'should get all posts with use case',
      build: () {
        when(() => mockGetAllPosts(any()))
            .thenAnswer((_) async => Right(tPosts));
        return cubit;
      },
      act: (cubit) => cubit.getPosts(),
      verify: (cubit) async {
        await untilCalled(() => mockGetAllPosts(any()));
        return verify(() => mockGetAllPosts(any()));
      },
    );

    blocTest<PostsCubit, PostsState>(
      'should emit [PostsLoading, PostsSuccess] when get all posts successfully',
      build: () {
        when(() => mockGetAllPosts(any()))
            .thenAnswer((_) async => Right(tPosts));
        return cubit;
      },
      act: (cubit) async {
        cubit.getPosts();
        await untilCalled(() => mockGetAllPosts(any()));
      },
      expect: () => [PostsLoading(), PostsSuccess(tPosts)],
    );

    blocTest<PostsCubit, PostsState>(
      'should emit [PostsLoading, PostsError] when getting data fails',
      build: () {
        when(() => mockGetAllPosts(any()))
            .thenAnswer((_) async => Left(ServerFailure()));
        return cubit;
      },
      act: (cubit) async {
        cubit.getPosts();
        await untilCalled(() => mockGetAllPosts(any()));
      },
      expect: () => [PostsLoading(), PostsError(kServerFailureMessage)],
    );

    blocTest<PostsCubit, PostsState>(
      'should emit [PostsLoading, PostsError] with a proper message for the error when getting data fails',
      build: () {
        when(() => mockGetAllPosts(any()))
            .thenAnswer((_) async => Left(NotFoundPostsCachedFailure()));
        return cubit;
      },
      act: (cubit) async {
        cubit.getPosts();
        await untilCalled(() => mockGetAllPosts(any()));
      },
      expect: () =>
          [PostsLoading(), PostsError(kNotFoundPostsCachedFailureMessage)],
    );
  });
}
