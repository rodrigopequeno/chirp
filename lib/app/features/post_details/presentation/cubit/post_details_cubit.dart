import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/entities/post.dart';
import '../../../../core/error/failure.dart';
import '../../domain/usecases/delete_post.dart';
import '../../domain/usecases/edit_post.dart';

part 'post_details_state.dart';

const kEditSuccessMessage = "Post edited successfully";
const kDeleteSuccessMessage = "Post deleted";
const kNotFoundPostFailureMessage = "Post not found, try updating";
const kDeletePostFailureMessage =
    "Error trying to delete the post, please try again later";
const kEditPostFailureMessage =
    "Error trying to edit post, please try again later";

class PostDetailsCubit extends Cubit<PostDetailsState> {
  final DeletePost deletePost;
  final EditPost editPost;

  PostDetailsCubit(
    this.deletePost,
    this.editPost,
  ) : super(PostDetailsInitial());

  Future<void> delete(String uid) async {
    emit(PostDetailsLoading());
    await Future.delayed(const Duration(seconds: 2));
    final result = await deletePost(ParamsDelete(uidPost: uid));
    await result.fold((l) {
      if (l is NotFoundPostFailure) {
        emit(PostDetailsError(kNotFoundPostFailureMessage));
      } else if (l is DeletePostFailure) {
        emit(PostDetailsError(kDeletePostFailureMessage));
      }
    }, (r) async {
      emit(PostDetailsDeleteSuccess(kDeleteSuccessMessage));
    });
  }

  Future<void> edit(String uid, String newContent) async {
    emit(PostDetailsLoading());
    await Future.delayed(const Duration(seconds: 2));
    final result = await editPost(ParamsEdit(uid: uid, newContent: newContent));
    await result.fold((l) {
      if (l is NotFoundPostFailure) {
        emit(PostDetailsError(kNotFoundPostFailureMessage));
      } else if (l is EditPostFailure) {
        emit(PostDetailsError(kEditPostFailureMessage));
      }
    }, (editedPost) async {
      emit(PostDetailsEditSuccess(kEditSuccessMessage, editedPost));
    });
  }
}
