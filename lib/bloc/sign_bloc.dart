import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

part 'sign_event.dart';
part 'sign_state.dart';

enum NeusHubSignType {
  signIn,
  signUp,
  resetPassword,
  editUser,
}

class NeusHubSignBloc extends Bloc<NeusHubSignEvent, NeusHubSignState> {
  NeusHubSignType signType = NeusHubSignType.signIn;

  NeusHubSignBloc() : super(NeusHubSignInitial()) {
    on<NeusHubSignEvent>((event, emit) {
      if (event is NeusHubSignInEvent) {
        signType = event.signType;
        emit(NeusHubSignChangedState(signType));
      } else if (event is NeusHubSignUpEvent) {
        signType = event.signType;
        emit(NeusHubSignChangedState(signType));
      }
    });
  }
}
