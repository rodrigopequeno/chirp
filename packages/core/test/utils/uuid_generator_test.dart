import 'package:core/utils/uuid_generator.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:uuid/uuid.dart';

class MockUuid extends Mock implements Uuid {}

void main() {
  late UuidGenerator uuidGenerator;
  late MockUuid mockUuid;

  setUp(() {
    mockUuid = MockUuid();
    uuidGenerator = UuidGeneratorImpl(mockUuid);
  });

  group('generated', () {
    test('should forward the call to Uuid.v4', () async {
      const tUuid = "ea18ebbf-6733-4426-b8ed-5a73bdcce049";
      when(() => mockUuid.v4()).thenReturn(tUuid);
      final result = uuidGenerator.generated;
      verify(() => uuidGenerator.generated);
      expect(result, tUuid);
    });
  });
}
