import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc() : super(SearchInitial()) {
    on<SearchInitialEvent>(searchInitialEvent);
  }
}

FutureOr<void> searchInitialEvent(
    SearchInitialEvent event, Emitter<SearchState> emit) async {
  emit(SearchLoadingState(message: "Loading.."));
  try {
    emit(SearchSuccessState());
  } catch (e) {
    emit(SearchLoadErrorState(error: e.toString()));
  }
}
