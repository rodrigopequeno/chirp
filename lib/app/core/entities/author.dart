import 'package:equatable/equatable.dart';

class Author extends Equatable {
  final String id;
  final String? image;
  final String authorName;

  const Author({
    required this.id,
    required this.authorName,
    this.image,
  });

  @override
  List<Object?> get props => [id, image, authorName];
}
