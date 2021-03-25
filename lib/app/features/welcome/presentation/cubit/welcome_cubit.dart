import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/cubit/auth_cubit.dart';
import '../../../../core/error/failure.dart';
import '../../domain/usecases/sign_in_with_name.dart';

part 'welcome_state.dart';

const kSignInFailureMessage = 'An error occurred, please try again later';

class WelcomeCubit extends Cubit<WelcomeState> {
  final SignInWithName signInWithName;
  final AuthCubit auth;

  WelcomeCubit(this.signInWithName, this.auth) : super(WelcomeLoadingInitial());

  Future<void> init() async {
    await Future.wait([
      Future.delayed(const Duration(milliseconds: 2000)),
      auth.checkSignIn()
    ]);
    if (auth.state is AuthLogged) {
      emit(WelcomeSuccess());
    } else if (auth.state is AuthDisconnected) {
      emit(WelcomeInitial());
    }
  }

  Future<void> signIn(String name) async {
    emit(WelcomeInitial());
    emit(WelcomeLoading());
    await Future<void>.delayed(const Duration(seconds: 1));
    final result = await signInWithName(Params(name: name));
    await result.fold((l) {
      if (l is SignInFailure) {
        emit(WelcomeError(kSignInFailureMessage));
      }
    }, (r) async {
      await auth.checkSignIn();
      emit(WelcomeSuccess());
    });
  }
}
