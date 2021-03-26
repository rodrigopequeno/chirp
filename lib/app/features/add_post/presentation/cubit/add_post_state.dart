part of 'add_post_cubit.dart';

abstract class AddPostState extends Equatable {
  final List properties;

  const AddPostState([this.properties = const <dynamic>[]]);

  @override
  List<Object> get props => [properties];
}

class AddPostInitial extends AddPostState {}

class AddPostLoading extends AddPostState {}

class AddPostSuccess extends AddPostState {}

class AddPostError extends AddPostState {
  final String message;

  AddPostError(this.message) : super([message]);
}
