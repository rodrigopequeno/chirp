import 'package:chirp/app/core/entities/author.dart';
import 'package:chirp/app/core/models/post_model.dart';
import 'package:chirp/app/features/add_post/domain/repositories/add_post_repository.dart';
import 'package:chirp/app/features/add_post/domain/usecases/create_post.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAddPostRepository extends Mock implements AddPostRepository {}

void main() {
  late CreatePost usecase;
  late MockAddPostRepository mockAddPostRepository;

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

  setUp(() {
    mockAddPostRepository = MockAddPostRepository();
    usecase = CreatePost(mockAddPostRepository);
  });

  test('should create post from the repository', () async {
    when(() => mockAddPostRepository.addPost(any()))
        .thenAnswer((_) async => const Right(unit));

    final result = await usecase(Params(tPost));

    expect(result, const Right(unit));
    verify(() => mockAddPostRepository.addPost(tPost));
    verifyNoMoreInteractions(mockAddPostRepository);
  });
}
