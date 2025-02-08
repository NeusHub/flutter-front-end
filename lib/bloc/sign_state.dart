part of 'sign_bloc.dart';

@immutable
sealed class NeusHubSignPageState {}

final class NeusHubSignPageInitial extends NeusHubSignPageState {
  final NeusHubSignType signType = NeusHubSignType.signIn;
}

final class NeusHubSignPageChangedState extends NeusHubSignPageState {
  final NeusHubSignType signType;

  NeusHubSignPageChangedState(this.signType);
}
