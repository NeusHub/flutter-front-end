part of 'sign_bloc.dart';

@immutable
sealed class SignEvent {}

final class SignInEvent extends SignEvent {
  final SignType signType = SignType.signIn;
}

final class SignUpEvent extends SignEvent {
  final SignType signType = SignType.signUp;
}

final class SignResetEvent extends SignEvent {
  final SignType signType = SignType.resetPassword;
}

final class SignEditEvent extends SignEvent {
  final SignType signType = SignType.editUser;
}
