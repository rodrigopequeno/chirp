import 'package:chirp/app/core/entities/author.dart';
import 'package:chirp/app/features/posts/data/models/author_model.dart';

class AddAuthorModel extends AuthorModel implements Author {
  const AddAuthorModel({required String id, required String authorName})
      : super(id: id, authorName: authorName);
}
