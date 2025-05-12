part of 'home_bloc.dart';

@immutable
sealed class HomeState {}

abstract class HomeActionState extends HomeState {}

final class HomeInitial extends HomeState {}

final class HomeInitialState extends HomeState {}

final class HomeSuccessState extends HomeState {
  final List<product_model> ProductList;

  HomeSuccessState({required this.ProductList});
}

final class HomeLoadingState extends HomeState {
  final String message;

  HomeLoadingState({required this.message});
}

final class HomeLoadErrorState extends HomeState {
  final String error;

  HomeLoadErrorState({required this.error});
}
