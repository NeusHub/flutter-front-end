part of 'sign_bloc.dart';

@immutable
sealed class NeusHubSignEvent {}

final class NeusHubSignChangePageEvent extends NeusHubSignEvent {
  final NeusHubSignType signType;

  NeusHubSignChangePageEvent(this.signType);
}
