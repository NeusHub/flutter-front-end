part of 'sign_bloc.dart';

@immutable
sealed class NeusHubSignState {}

final class NeusHubSignInitial extends NeusHubSignState {
  final NeusHubSignType signType = NeusHubSignType.signIn;
}

final class NeusHubSignChangedState extends NeusHubSignState {
  final NeusHubSignType signType;

  NeusHubSignChangedState(this.signType);
}
