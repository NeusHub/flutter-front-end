part of 'sign_bloc.dart';

@immutable
sealed class SignState {}

final class SignInitial extends SignState {
  final SignType signType = SignType.signIn;
}

final class SignChangedState extends SignState {
  final SignType signType;

  SignChangedState(this.signType);
}
