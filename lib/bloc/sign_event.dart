part of 'sign_bloc.dart';

@immutable
sealed class NeusHubSignEvent {}

final class NeusHubSignInEvent extends NeusHubSignEvent {
  final NeusHubSignType signType = NeusHubSignType.signIn;
}

final class NeusHubSignUpEvent extends NeusHubSignEvent {
  final NeusHubSignType signType = NeusHubSignType.signUp;
}

final class NeusHubSignResetEvent extends NeusHubSignEvent {
  final NeusHubSignType signType = NeusHubSignType.resetPassword;
}

final class NeusHubSignEditEvent extends NeusHubSignEvent {
  final NeusHubSignType signType = NeusHubSignType.editUser;
}
