import 'dart:async';

import 'package:bloc/bloc.dart';

import 'package:flutter/cupertino.dart';
import 'package:groceryapp/Data/models/product_model.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<HomeInitialEvent>(homeInitialEvent);
    on<HomeLoadingEvent>(homeLoading_event);
    on<HomeLoadingError>(homeLoadError_event);
  }
}

FutureOr<void> homeInitialEvent(
    HomeInitialEvent event, Emitter<HomeState> emit) async {
  emit(HomeLoadingState(message: "Starting up...")); // Unified loading state
  try {
    debugPrint("Loading started");
    await Future.delayed(Duration(seconds: 3)); // Simulate app loading
    debugPrint("Loading finished");

    // Convert the fetched documents to a list of product_model
    List<product_model> productList = await fetchProducts();

    // Emit the success state with the fetched product list
    emit(HomeSuccessState(ProductList: productList));
  } catch (e) {
    debugPrint("Error occurred: $e");
    emit(HomeLoadErrorState(error: e.toString()));
  }
}

FutureOr<void> homeLoading_event(
    HomeLoadingEvent event, Emitter<HomeState> emit) async {
  emit(HomeLoadingState(message: 'Loading...'));
}

FutureOr<void> homeLoadError_event(
    HomeLoadingError event, Emitter<HomeState> emit) async {
  emit(HomeLoadErrorState(error: event.error));
}
