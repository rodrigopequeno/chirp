import 'package:bloc_test/bloc_test.dart';
import 'package:chirp/app/core/cubit/auth_cubit.dart';
import 'package:chirp/app/core/utils/character_limit.dart';
import 'package:chirp/app/core/utils/uuid_generator.dart';
import 'package:chirp/app/features/add_post/data/models/add_post_model.dart';
import 'package:chirp/app/features/add_post/domain/entities/add_author.dart';
import 'package:chirp/app/features/add_post/domain/usecases/create_post.dart';
import 'package:chirp/app/features/add_post/presentation/cubit/add_post_cubit.dart';
import 'package:chirp/app/features/welcome/domain/entities/logged_user.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockCreatePost extends Mock implements CreatePost {}

class MockCharacterLimit extends Mock implements CharacterLimit {}

class MockUuidGenerator extends Mock implements UuidGenerator {}

class MockAuthCubit extends Mock implements AuthCubit {}

void main() {
  late AddPostCubit cubit;
  late MockCreatePost mockCreatePost;
  late MockCharacterLimit mockCharacterLimit;
  late MockUuidGenerator mockUuidGenerator;
  late MockAuthCubit mockAuthCubit;

  const tUuid = "75418de8-cf36-47c6-8850-3f958fb1b45d";
  const tName = "Rodrigo Pequeno";
  const tLoggedUser = LoggedUser(uid: tUuid, name: tName);
  const tAuthor = AddAuthor(
      id: "75418de8-cf36-47c6-8850-3f958fb1b45d",
      authorName: "Rodrigo Pequeno");
  const tContent = "Seja bem vindo";
  final tDateTime = DateTime.now();
  final tPost = AddPostModel(
      id: "75418de8-cf36-47c6-8850-3f958fb1b45d",
      author: tAuthor,
      content: tContent,
      published: tDateTime);

  setUpAll(() {
    registerFallbackValue<Params>(Params(tPost));
  });

  setUp(() {
    mockCreatePost = MockCreatePost();
    mockCharacterLimit = MockCharacterLimit();
    mockUuidGenerator = MockUuidGenerator();
    mockAuthCubit = MockAuthCubit();

    cubit = AddPostCubit(
        mockCreatePost, mockCharacterLimit, mockUuidGenerator, mockAuthCubit);
    when(() => mockAuthCubit.state).thenReturn(AuthLogged(tLoggedUser));
    when(() => mockUuidGenerator.generated).thenReturn(
      "75418de8-cf36-47c6-8850-3f958fb1b45d",
    );
  });

  tearDown(() {
    cubit.close();
  });
  test('initialState should be AddPostInitial', () async {
    expect(cubit.state, isA<AddPostInitial>());
  });

  void setUpMockCharacterLimitSuccess() {
    when(() => mockCharacterLimit.isWithinTheLimit(any<String>()))
        .thenReturn(true);
  }

  group('addPost', () {
    group('Character Limit', () {
      test('''should call the Character Limit to validate the content''',
          () async {
        setUpMockCharacterLimitSuccess();
        when(() => mockCreatePost(any()))
            .thenAnswer((_) async => const Right(unit));
        cubit.addPost(tContent);
        await untilCalled(() => mockCharacterLimit.isWithinTheLimit(tContent));
        verify(() => mockCharacterLimit.isWithinTheLimit(tContent));
      });

      blocTest<AddPostCubit, AddPostState>(
        'should emit [AddPostError] when the input content with characters above the limit',
        build: () {
          when(() => mockCharacterLimit.isWithinTheLimit(any<String>()))
              .thenReturn(false);
          return cubit;
        },
        act: (cubit) => cubit.addPost(tContent),
        expect: () => [isA<AddPostError>()],
      );
    });
  });

  blocTest<AddPostCubit, AddPostState>(
    'should add post with use case',
    build: () {
      setUpMockCharacterLimitSuccess();
      when(() => mockCreatePost(any()))
          .thenAnswer((_) async => const Right(unit));
      return cubit;
    },
    act: (cubit) => cubit.addPost(tContent),
    verify: (cubit) async {
      await untilCalled(() => mockCreatePost(any()));
      return verify(() => mockCreatePost(any()));
    },
  );

  blocTest<AddPostCubit, AddPostState>(
    'should emit [AddPostLoading, AddPostSuccess] when add post with successfully',
    build: () {
      setUpMockCharacterLimitSuccess();
      when(() => mockCreatePost(any()))
          .thenAnswer((_) async => const Right(unit));
      return cubit;
    },
    act: (cubit) async {
      cubit.addPost(tContent);
      await untilCalled(() => mockCreatePost(any()));
    },
    expect: () => [AddPostLoading(), AddPostSuccess()],
  );
}
