import 'package:bloc_test/bloc_test.dart';
import 'package:chirp/app/core/error/failure.dart';
import 'package:chirp/app/core/models/author_model.dart';
import 'package:chirp/app/core/models/post_model.dart';
import 'package:chirp/app/features/post_details/domain/usecases/delete_post.dart';
import 'package:chirp/app/features/post_details/domain/usecases/edit_post.dart';
import 'package:chirp/app/features/post_details/presentation/cubit/post_details_cubit.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockDeletePost extends Mock implements DeletePost {}

class MockEditPost extends Mock implements EditPost {}

// ignore: avoid_implementing_value_types
class ParamsDeleteFake extends Fake implements ParamsDelete {}

// ignore: avoid_implementing_value_types
class ParamsEditFake extends Fake implements ParamsEdit {}

void main() {
  late PostDetailsCubit cubit;
  late MockDeletePost mockDeletePost;
  late MockEditPost mockEditPost;

  setUpAll(() {
    registerFallbackValue<ParamsDelete>(ParamsDeleteFake());
    registerFallbackValue<ParamsEdit>(ParamsEditFake());
  });
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
    mockDeletePost = MockDeletePost();
    mockEditPost = MockEditPost();

    cubit = PostDetailsCubit(mockDeletePost, mockEditPost);
  });

  tearDown(() {
    cubit.close();
  });

  test('initialState should be PostDetailsInitial', () async {
    expect(cubit.state, isA<PostDetailsInitial>());
  });

  group('DeletePost', () {
    blocTest<PostDetailsCubit, PostDetailsState>(
      'should delete post from concrete use case',
      build: () {
        when(() => mockDeletePost(any()))
            .thenAnswer((_) async => const Right(unit));
        return cubit;
      },
      act: (cubit) => cubit.delete(tUid),
      verify: (cubit) =>
          verify(() => mockDeletePost(const ParamsDelete(uidPost: tUid))),
    );

    blocTest<PostDetailsCubit, PostDetailsState>(
      'should emit [PostDetailsLoading, PostDetailsDeleteSuccess] when the post is successfully deleted',
      build: () {
        when(() => mockDeletePost(any()))
            .thenAnswer((_) async => const Right(unit));
        return cubit;
      },
      act: (cubit) => cubit.delete(tUid),
      expect: () => [
        PostDetailsLoading(),
        PostDetailsDeleteSuccess(kDeleteSuccessMessage)
      ],
    );

    blocTest<PostDetailsCubit, PostDetailsState>(
      'should emit [PostDetailsLoading, PostDetailsError] when the post to be deleted is not found',
      build: () {
        when(() => mockDeletePost(any()))
            .thenAnswer((_) async => Left(NotFoundPostFailure()));
        return cubit;
      },
      act: (cubit) => cubit.delete(tUid),
      expect: () =>
          [PostDetailsLoading(), PostDetailsError(kNotFoundPostFailureMessage)],
    );

    blocTest<PostDetailsCubit, PostDetailsState>(
      '''should emit [PostDetailsLoading, PostDetailsError] when an error occurs when deleting a post''',
      build: () {
        when(() => mockDeletePost(any()))
            .thenAnswer((_) async => Left(DeletePostFailure()));
        return cubit;
      },
      act: (cubit) => cubit.delete(tUid),
      expect: () =>
          [PostDetailsLoading(), PostDetailsError(kDeletePostFailureMessage)],
    );
  });

  group('EditPost', () {
    const tNewContent = "hi";
    blocTest<PostDetailsCubit, PostDetailsState>(
      'should edit post from concrete use case',
      build: () {
        when(() => mockEditPost(any())).thenAnswer((_) async => Right(tPost));
        return cubit;
      },
      act: (cubit) => cubit.edit(tUid, tNewContent),
      verify: (cubit) => verify(() =>
          mockEditPost(const ParamsEdit(uid: tUid, newContent: tNewContent))),
    );

    blocTest<PostDetailsCubit, PostDetailsState>(
      'should emit [PostDetailsLoading, PostDetailsEditSuccess] when the post is successfully edited',
      build: () {
        when(() => mockEditPost(any())).thenAnswer((_) async => Right(tPost));
        return cubit;
      },
      act: (cubit) => cubit.edit(tUid, tNewContent),
      expect: () => [
        PostDetailsLoading(),
        PostDetailsEditSuccess(kEditSuccessMessage, tPost)
      ],
    );

    blocTest<PostDetailsCubit, PostDetailsState>(
      'should emit [PostDetailsLoading, PostDetailsError] when the post to be edit is not found',
      build: () {
        when(() => mockEditPost(any()))
            .thenAnswer((_) async => Left(NotFoundPostFailure()));
        return cubit;
      },
      act: (cubit) => cubit.edit(tUid, tNewContent),
      expect: () =>
          [PostDetailsLoading(), PostDetailsError(kNotFoundPostFailureMessage)],
    );

    blocTest<PostDetailsCubit, PostDetailsState>(
      '''should emit [PostDetailsLoading, PostDetailsError] when an error occurs when editing a post''',
      build: () {
        when(() => mockEditPost(any()))
            .thenAnswer((_) async => Left(EditPostFailure()));
        return cubit;
      },
      act: (cubit) => cubit.edit(tUid, tNewContent),
      expect: () =>
          [PostDetailsLoading(), PostDetailsError(kEditPostFailureMessage)],
    );
  });
}
