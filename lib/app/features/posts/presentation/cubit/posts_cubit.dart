import 'package:bloc/bloc.dart';
import 'package:chirp/app/core/error/failure.dart';
import 'package:chirp/app/core/usecases/usecase.dart';
import 'package:chirp/app/features/posts/domain/entities/posts.dart';
import 'package:chirp/app/features/posts/domain/usecases/get_all_posts.dart';
import 'package:equatable/equatable.dart';

part 'posts_state.dart';

const String kServerFailureMessage =
    'Ocorreu um erro, verifique sua conexão e tente novamente';
const String kNotFoundPostsCachedFailureMessage =
    'Falha na conexão, tente novamente mais tarde';

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
      emit(PostsSuccess(posts));
    });
  }
}
