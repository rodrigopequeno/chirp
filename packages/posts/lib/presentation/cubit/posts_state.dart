part of 'posts_cubit.dart';

abstract class PostsState extends Equatable {
  final List properties;

  const PostsState([this.properties = const <dynamic>[]]);

  @override
  List<Object> get props => [properties];
}

class PostsInitial extends PostsState {}

class PostsLoading extends PostsState {}

class PostsSuccess extends PostsState {
  final List<Post> posts;

  PostsSuccess(this.posts) : super([posts]);
}

class PostsError extends PostsState {
  final String message;

  PostsError(this.message) : super([message]);
}
