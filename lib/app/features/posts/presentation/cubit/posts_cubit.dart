import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/entities/post.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/usecases/usecase.dart';
import '../../domain/usecases/get_all_posts.dart';

part 'posts_state.dart';

const String kServerFailureMessage =
    'An error occurred, check your connection and try again';
const String kNotFoundPostsCachedFailureMessage =
    'Connection failed, please try again later';

class PostsCubit extends Cubit<PostsState> {
  final GetAllPosts getAllPosts;

  PostsCubit(this.getAllPosts) : super(PostsInitial());

  Future<void> getPosts() async {
    emit(PostsLoading());
    final result = await getAllPosts(const NoParams());
    result.fold((l) {
      if (l is ServerFailure) {
        emit(PostsError(kServerFailureMessage));
      } else if (l is NotFoundPostsCachedFailure) {
        emit(PostsError(kNotFoundPostsCachedFailureMessage));
      }
    }, (posts) {
      posts.sort();
      emit(PostsSuccess(posts));
    });
  }
}
