import 'package:core/entities/author.dart';
import 'package:core/entities/post.dart';
import 'package:post_details/domain/repositories/post_details_repository.dart';
import 'package:post_details/domain/usecases/edit_post.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockPostDetailsRepository extends Mock implements PostDetailsRepository {}

void main() {
  late EditPost usecase;
  late MockPostDetailsRepository mockPostDetailsRepository;

  setUp(() {
    mockPostDetailsRepository = MockPostDetailsRepository();
    usecase = EditPost(mockPostDetailsRepository);
  });

  const newContent = "new";
  const tUid = "uid";
  final tDateTime = DateTime.now();
  final tPost = Post(
    content: "",
    id: tUid,
    published: tDateTime,
    author: const Author(id: "", authorName: ""),
  );

  test('should edit post from the repository', () async {
    when(() => mockPostDetailsRepository.editPost(any(), any()))
        .thenAnswer((_) async => Right(tPost));

    final result =
        await usecase(const ParamsEdit(newContent: newContent, uid: tUid));

    expect(result, Right(tPost));
    verify(() => mockPostDetailsRepository.editPost(tUid, newContent));
    verifyNoMoreInteractions(mockPostDetailsRepository);
  });
}
