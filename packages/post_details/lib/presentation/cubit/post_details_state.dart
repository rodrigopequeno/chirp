part of 'post_details_cubit.dart';

abstract class PostDetailsState extends Equatable {
  final List properties;

  const PostDetailsState([this.properties = const <dynamic>[]]);

  @override
  List<Object> get props => [properties];
}

class PostDetailsInitial extends PostDetailsState {}

class PostDetailsLoading extends PostDetailsState {}

class PostDetailsDeleteSuccess extends PostDetailsState {
  final String message;

  PostDetailsDeleteSuccess(this.message) : super([message]);
}

class PostDetailsEditSuccess extends PostDetailsState {
  final String message;
  final Post editedPost;

  PostDetailsEditSuccess(this.message, this.editedPost)
      : super([message, editedPost]);
}

class PostDetailsError extends PostDetailsState {
  final String message;

  PostDetailsError(this.message) : super([message]);
}
