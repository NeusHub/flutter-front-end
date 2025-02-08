part of 'sign_bloc.dart';

@immutable
sealed class NeusHubSignPageEvent {}

final class NeusHubSignChangePageEvent extends NeusHubSignPageEvent {
  final NeusHubSignType signType;

  NeusHubSignChangePageEvent(this.signType);
}

// -----------------------------------------------------------------------------

@immutable
sealed class NeusHubSignActionEvent {}

// sign up

final class NeusHubSignUpActionEvent extends NeusHubSignActionEvent {
  final String? email, password, fullName;

  NeusHubSignUpActionEvent({
    this.email,
    this.password,
    this.fullName,
  });
}

// sign in

final class NeusHubSignInActionEvent extends NeusHubSignActionEvent {
  final String? email, password, ip;
  final bool? remember;

  NeusHubSignInActionEvent({
    this.email,
    this.password,
    this.ip,
    this.remember,
  });
}

// sign token

final class NeusHubSignTokenActionEvent extends NeusHubSignActionEvent {
  final String? email, token;

  NeusHubSignTokenActionEvent({
    this.email,
    this.token,
  });
}
