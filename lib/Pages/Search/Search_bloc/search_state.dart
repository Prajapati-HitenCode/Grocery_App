part of 'search_bloc.dart';

@immutable
sealed class SearchState {}

final class SearchInitial extends SearchState {}

final class SearchSuccessState extends SearchState{}

final class SearchLoadingState extends SearchState{}

final class SearchLoadErrorState extends SearchState{}