part of 'search_bloc.dart';

@immutable
sealed class SearchState {}

final class SearchInitial extends SearchState {}

final class SearchActionState extends SearchState{}

final class SearchSuccessState extends SearchState{
  final List<product_model> ProductList;

  SearchSuccessState({required this.ProductList});
}

final class SearchLoadingState extends SearchState{
  final String message;

  SearchLoadingState({required this.message});
}

final class SearchLoadErrorState extends SearchState{
  final String error;

  SearchLoadErrorState({required this.error});
}