import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:groceryapp/Data/product_model.dart';
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
    QuerySnapshot snapshot =
    await FirebaseFirestore.instance.collection('product').get();

    // Convert the fetched documents to a list of product_model
    List<product_model> productList =
    snapshot.docs.map((doc) => product_model.fromDocument(doc)).toList();
    emit(SearchSuccessState());
  } catch (e) {
    emit(SearchLoadErrorState(error: e.toString()));
  }
}
