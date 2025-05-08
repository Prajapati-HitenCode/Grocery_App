part of 'home_bloc.dart';

@immutable
sealed class HomeEvent {}

final class HomeInitialEvent extends HomeEvent{}

final class HomeLoad_Success_event extends HomeEvent{}

final class HomeLoading_event extends HomeEvent{}

final class HomeLoadError_event extends HomeEvent{
  final String error;
  HomeLoadError_event(this.error);
}

final class ProductFilter_Event extends HomeEvent{}