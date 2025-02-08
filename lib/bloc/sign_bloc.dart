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

class NeusHubSignActionBloc
    extends Bloc<NeusHubSignActionEvent, NeusHubSignActionState> {
  NeusHubSignType signType = NeusHubSignType.signIn;

  NeusHubSignActionBloc() : super(NeusHubSignActionInitial()) {
    on<NeusHubSignActionEvent>((event, emit) {
      if (event is NeusHubSignUpActionEvent) {
        signType = NeusHubSignType.signUp;
        emit(NeusHubSignActionChangedState(
          signType: signType,
          email: event.email,
          password: event.password,
          fullName: event.fullName,
        ));
      } else if (event is NeusHubSignInActionEvent) {
        signType = NeusHubSignType.signIn;
        emit(NeusHubSignActionChangedState(
          signType: signType,
          email: event.email,
          password: event.password,
          ip: event.ip,
          remember: event.remember,
        ));
      } else if (event is NeusHubSignUpActionEvent) {
        signType = NeusHubSignType.signToken;
        emit(NeusHubSignActionChangedState(
          signType: signType,
          email: event.email,
          password: event.password,
          fullName: event.fullName,
        ));
      }
    });
  }
}
