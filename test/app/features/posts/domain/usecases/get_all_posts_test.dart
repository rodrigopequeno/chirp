import 'package:chirp/app/core/usecases/usecase.dart';
import 'package:chirp/app/features/posts/domain/entities/posts.dart';
import 'package:chirp/app/features/posts/domain/repositories/posts_repository.dart';
import 'package:chirp/app/features/posts/domain/usecases/get_all_posts.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockPostsRepository extends Mock implements PostsRepository {}

void main() {
  late GetAllPosts usecase;
  late MockPostsRepository mockPostsRepository;

  setUp(() {
    mockPostsRepository = MockPostsRepository();
    usecase = GetAllPosts(mockPostsRepository);
  });

  final tPost = Posts(
    authorName: 'Rodrigo Pequeno',
    content: "Seja bem vindo",
    published: DateTime.now(),
  );

  test('should get all posts from the repository', () async {
    when(() => mockPostsRepository.getAllPosts())
        .thenAnswer((_) async => Right(tPost));

    final result = await usecase(const NoParams());

    expect(result, Right(tPost));
    verify(() => mockPostsRepository.getAllPosts());
    verifyNoMoreInteractions(mockPostsRepository);
  });
}
