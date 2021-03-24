import 'package:chirp/app/core/utils/character_limit.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late CharacterLimit characterLimit;

  setUp(() {
    characterLimit = CharacterLimit();
  });

  group('isWithinTheLimit', () {
    test(
        '''should return true when the string is less than the kCharacterLimit''',
        () async {
      final str = List.generate(kCharacterLimit, (index) => "#").join();
      final result = characterLimit.isWithinTheLimit(str);
      expect(result, true);
    });

    test(
        '''should return false when the string is greater than the kCharacterLimit''',
        () async {
      final str = List.generate(kCharacterLimit + 1, (index) => "#").join();
      final result = characterLimit.isWithinTheLimit(str);
      expect(result, false);
    });
  });
}
