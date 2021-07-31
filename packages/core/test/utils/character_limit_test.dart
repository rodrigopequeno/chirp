import 'package:core/utils/character_limit.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late CharacterLimit characterLimit;

  setUp(() {
    characterLimit = CharacterLimit();
  });

  group('isWithinTheLimitCreation', () {
    test(
        '''should return true when the string is less than the kCharacterLimitCreation''',
        () async {
      final str = List.generate(kCharacterLimitCreation, (index) => "#").join();
      final result = characterLimit.isWithinTheLimitCreation(str);
      expect(result, true);
    });

    test(
        '''should return false when the string is greater than the kCharacterLimitCreation''',
        () async {
      final str =
          List.generate(kCharacterLimitCreation + 1, (index) => "#").join();
      final result = characterLimit.isWithinTheLimitCreation(str);
      expect(result, false);
    });
  });

  group('isWithinTheLimit', () {
    test(
        '''should return true when the string is less than the kCharacterLimitPreview''',
        () async {
      final str = List.generate(kCharacterLimitPreview, (index) => "#").join();
      final result = characterLimit.isWithinTheLimitPreview(str);
      expect(result, true);
    });

    test(
        '''should return false when the string is greater than the kCharacterLimitPreview''',
        () async {
      final str =
          List.generate(kCharacterLimitPreview + 1, (index) => "#").join();
      final result = characterLimit.isWithinTheLimitPreview(str);
      expect(result, false);
    });
  });
}
