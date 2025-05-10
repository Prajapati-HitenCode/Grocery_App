part of 'home_bloc.dart';

@immutable
sealed class HomeEvent {}

final class HomeInitialEvent extends HomeEvent {}

final class HomeSuccessEvent extends HomeEvent {}

final class HomeLoadingEvent extends HomeEvent {}

final class HomeLoadingError extends HomeEvent {
  final String error;
  HomeLoadingError(this.error);
}
