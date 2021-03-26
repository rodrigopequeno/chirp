const kCharacterLimitCreation = 380;
const kCharacterLimitPreview = 280;

class CharacterLimit {
  bool isWithinTheLimitCreation(String characters) {
    return characters.length <= kCharacterLimitCreation;
  }

  bool isWithinTheLimitPreview(String characters) {
    return characters.length <= kCharacterLimitPreview;
  }
}
