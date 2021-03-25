import 'package:bloc/bloc.dart';
import 'package:chirp/app/core/cubit/auth_cubit.dart';
import 'package:chirp/app/core/utils/character_limit.dart';
import 'package:chirp/app/core/utils/uuid_generator.dart';
import 'package:chirp/app/features/add_post/data/models/add_author_model.dart';
import 'package:chirp/app/features/add_post/data/models/add_post_model.dart';
import 'package:chirp/app/features/add_post/domain/usecases/create_post.dart';
import 'package:equatable/equatable.dart';

part 'add_post_state.dart';

const kIsOutOfLimitFailureMessage = "O limite é 280 caracteres";
const kDefaultFailureMessage = "Ocorreu um erro, tente novamente mais tarde";

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
