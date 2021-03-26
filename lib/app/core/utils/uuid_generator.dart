import 'package:uuid/uuid.dart';

abstract class UuidGenerator {
  String get generated;
}

class UuidGeneratorImpl implements UuidGenerator {
  final Uuid uuid;

  UuidGeneratorImpl(this.uuid);

  @override
  String get generated => uuid.v4();
}
