import '../../../../core/models/author_model.dart';

class AddAuthorModel extends AuthorModel {
  const AddAuthorModel({required String id, required String authorName})
      : super(id: id, authorName: authorName);
}
