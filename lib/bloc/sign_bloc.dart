import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

part 'sign_event.dart';
part 'sign_state.dart';

enum SignType {
  signIn,
  signUp,
  resetPassword,
  editUser,
}

class SignBloc extends Bloc<SignEvent, SignState> {
  SignType signType = SignType.signIn;

  SignBloc() : super(SignInitial()) {
    on<SignEvent>((event, emit) {
      if (event is SignInEvent) {
        signType = event.signType;
        emit(SignChangedState(signType));
      } else if (event is SignUpEvent) {
        signType = event.signType;
        emit(SignChangedState(signType));
      }
    });
  }
}
