import '../../../../core/entities/author.dart';

class ListingAuthor extends Author {
  const ListingAuthor({
    required String id,
    required String authorName,
  }) : super(authorName: authorName, id: id);

  @override
  List<Object?> get props => [id, authorName];
}
