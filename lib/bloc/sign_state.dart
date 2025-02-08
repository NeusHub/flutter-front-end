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

// sign

@immutable
sealed class NeusHubSignActionState {}

final class NeusHubSignActionInitial extends NeusHubSignActionState {
  late final String? email, fullName, password, newPassword, ip, token;
}

final class NeusHubSignActionChangedState extends NeusHubSignActionState {
  final String? email, fullName, password, newPassword, ip, token;
  final bool? remember;
  final NeusHubSignType signType;

  NeusHubSignActionChangedState({
    this.email,
    this.password,
    this.newPassword,
    this.fullName,
    this.ip,
    this.token,
    this.remember,
    required this.signType,
  });
}
