import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

part 'sign_event.dart';
part 'sign_state.dart';

enum NeusHubSignType {
  signIn,
  signUp,
  signToken,
  resetPassword,
  editUser,
}

class NeusHubSignPageBloc
    extends Bloc<NeusHubSignPageEvent, NeusHubSignPageState> {
  NeusHubSignType signType = NeusHubSignType.signIn;

  NeusHubSignPageBloc() : super(NeusHubSignPageInitial()) {
    on<NeusHubSignPageEvent>((event, emit) {
      if (event is NeusHubSignChangePageEvent) {
        signType = event.signType;
        emit(NeusHubSignPageChangedState(signType));
      }
    });
  }
}
