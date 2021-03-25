import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/cubit/auth_cubit.dart';
import '../../../../core/utils/character_limit.dart';
import '../../../../core/utils/uuid_generator.dart';
import '../../data/models/add_author_model.dart';
import '../../data/models/add_post_model.dart';
import '../../domain/usecases/create_post.dart';

part 'add_post_state.dart';

const kIsOutOfLimitFailureMessage = "The limit is 280 characters";
const kDefaultFailureMessage = "An error occurred, please try again later";

class AddPostCubit extends Cubit<AddPostState> {
  final CreatePost createPost;
  final UuidGenerator uuidGenerator;
  final CharacterLimit characterLimit;
  final AuthCubit authCubit;

  AddPostCubit(
      this.createPost, this.characterLimit, this.uuidGenerator, this.authCubit)
      : super(AddPostInitial());

  Future<void> addPost(String content) async {
    final isWithinTheLimit = characterLimit.isWithinTheLimit(content);
    if (!isWithinTheLimit) {
      emit(AddPostError(kIsOutOfLimitFailureMessage));
    } else {
      emit(AddPostLoading());
      await Future<void>.delayed(const Duration(seconds: 1));
      final logged = authCubit.state as AuthLogged;
      final author = AddAuthorModel(
        id: logged.user.uid,
        authorName: logged.user.name,
      );
      final post = AddPostModel(
          id: uuidGenerator.generated,
          author: author,
          published: DateTime.now(),
          content: content);
      final result = await createPost(Params(post));
      result.fold((l) {
        emit(AddPostError(kDefaultFailureMessage));
      }, (r) {
        emit(AddPostSuccess());
      });
    }
  }
}
