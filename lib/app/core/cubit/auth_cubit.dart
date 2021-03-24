import 'package:bloc/bloc.dart';
import 'package:chirp/app/core/usecases/usecase.dart';
import 'package:chirp/app/features/welcome/domain/entities/logged_user.dart';
import 'package:chirp/app/features/welcome/domain/usecases/get_logged_user.dart';
import 'package:chirp/app/features/welcome/domain/usecases/sign_out.dart';
import 'package:equatable/equatable.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final GetLoggedUser getLoggedUser;
  final SignOut signOut;

  AuthCubit(this.getLoggedUser, this.signOut) : super(AuthInitial());

  Future<void> checkSignIn() async {
    final result = await getLoggedUser(const NoParams());
    result.fold((l) {
      emit(AuthDisconnected());
    }, (user) {
      emit(AuthLogged(user));
    });
  }

  Future<void> logout() async {
    final result = await signOut(const NoParams());
    result.fold((l) {}, (r) {
      emit(AuthDisconnected());
    });
  }
}
