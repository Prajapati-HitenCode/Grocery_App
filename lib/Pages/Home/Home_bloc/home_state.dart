part of 'home_bloc.dart';

@immutable
sealed class HomeState {}

abstract class HomeActionState extends HomeState{}

final class HomeInitial extends HomeState {}

final class HomeInitialState extends HomeState{}

final class HomeLoadSuccess_state extends HomeState{
  final List<product_model> productList;

  HomeLoadSuccess_state({required this.productList});
}

final class HomeLoading_state extends HomeState{
  final String message;

  HomeLoading_state({required this.message});

}

final class HomeLoadError_state extends HomeState{
  final String error;

  HomeLoadError_state({required this.error});
}


