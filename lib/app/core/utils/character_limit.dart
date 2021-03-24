const kCharacterLimit = 280;

class CharacterLimit {
  bool isWithinTheLimit(String characters) {
    return characters.length <= kCharacterLimit;
  }
}
