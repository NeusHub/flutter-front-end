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
      if (event is NeusHubSignChangePageEvent) {
        signType = event.signType;
        emit(NeusHubSignPageChangedState(signType));
      }
    });
  }
}
