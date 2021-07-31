import 'package:post_details/domain/repositories/post_details_repository.dart';
import 'package:post_details/domain/usecases/delete_post.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockPostDetailsRepository extends Mock implements PostDetailsRepository {}

void main() {
  late DeletePost usecase;
  late MockPostDetailsRepository mockPostDetailsRepository;

  setUp(() {
    mockPostDetailsRepository = MockPostDetailsRepository();
    usecase = DeletePost(mockPostDetailsRepository);
  });

  const tUid = "uid";

  test('should delete post from the repository', () async {
    when(() => mockPostDetailsRepository.deletePost(any()))
        .thenAnswer((_) async => const Right(unit));

    final result = await usecase(const ParamsDelete(uidPost: tUid));

    expect(result, const Right(unit));
    verify(() => mockPostDetailsRepository.deletePost(tUid));
    verifyNoMoreInteractions(mockPostDetailsRepository);
  });
}
