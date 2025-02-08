part of 'sign_bloc.dart';

@immutable
sealed class NeusHubSignPageEvent {}

final class NeusHubSignChangePageEvent extends NeusHubSignPageEvent {
  final NeusHubSignType signType;

  NeusHubSignChangePageEvent(this.signType);
}
