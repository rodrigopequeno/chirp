import 'package:chirp/app/core/entities/post.dart';
import 'package:chirp/app/core/usecases/usecase.dart';
import 'package:chirp/app/features/posts/domain/entities/author.dart';
import 'package:chirp/app/features/posts/domain/entities/post.dart';
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

  const author = ListingAuthor(
      id: "75418de8-cf36-47c6-8850-3f958fb1b45d",
      authorName: "Rodrigo Pequeno");
  final tPosts = List<Post>.from([
    ListingPost(
      id: '0',
      author: author,
      content: "Seja bem vindo",
      published: DateTime.now(),
    )
  ]);

  test('should get all posts from the repository', () async {
    when(() => mockPostsRepository.getAllPosts())
        .thenAnswer((_) async => Right(tPosts));

    final result = await usecase(const NoParams());

    expect(result, Right(tPosts));
    verify(() => mockPostsRepository.getAllPosts());
    verifyNoMoreInteractions(mockPostsRepository);
  });
}
