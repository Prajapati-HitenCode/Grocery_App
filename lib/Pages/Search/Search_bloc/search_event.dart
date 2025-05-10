part of 'search_bloc.dart';

@immutable
sealed class SearchEvent {}

class SearchInitialEvent extends SearchEvent{}

class SearchSuccessEvent extends SearchEvent{}

class SearchLoadErrorEvent extends SearchEvent{}

class SearchLoadingEvent extends SearchEvent{}

