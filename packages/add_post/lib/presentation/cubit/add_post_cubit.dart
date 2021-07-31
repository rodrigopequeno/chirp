import 'package:add_post/domain/usecases/create_post.dart';
import 'package:auth/cubit/auth_cubit.dart';
import 'package:bloc/bloc.dart';
import 'package:core/models/author_model.dart';
import 'package:core/models/post_model.dart';
import 'package:core/utils/character_limit.dart';
import 'package:core/utils/uuid_generator.dart';
import 'package:equatable/equatable.dart';

part 'add_post_state.dart';

const kIsOutOfLimitFailureMessage =
    "The limit is $kCharacterLimitCreation characters";
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
    emit(AddPostLoading());
    final isWithinTheLimitCreation =
        characterLimit.isWithinTheLimitCreation(content);
    if (!isWithinTheLimitCreation) {
      emit(AddPostError(kIsOutOfLimitFailureMessage));
    } else {
      emit(AddPostLoading());
      await Future<void>.delayed(const Duration(seconds: 1));
      final logged = authCubit.state as AuthLogged;
      final author = AuthorModel(
        id: logged.user.uid,
        authorName: logged.user.name,
        image: logged.user.image,
      );
      final post = PostModel(
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
