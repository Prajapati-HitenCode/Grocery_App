import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<HomeInitialEvent>(homeInitialEvent);
    on<HomeLoading_event>(homeLoading_event);
    on<HomeLoadError_event>(homeLoadError_event);
  }
}
FutureOr<void> homeInitialEvent(HomeInitialEvent event, Emitter<HomeState> emit) async {
  try {
    debugPrint("Loading started");
    emit(HomeLoading_state(message: "Starting up...")); // Unified loading state
    await Future.delayed(Duration(seconds: 3)); // Simulate app loading
    debugPrint("Loading finished");

    // Fetch data from Firestore here
    emit(HomeLoading_state(message: "Loading products...")); // Update message for data loading
    await Future.delayed(Duration(seconds: 3)); // Simulate data loading delay

    emit(HomeLoadSuccess_state());
  } catch (e) {
    debugPrint("Error occurred: $e");
    emit(HomeLoadError_state(error: e.toString()));
  }
}
FutureOr<void> homeLoading_event(HomeLoading_event event, Emitter<HomeState> emit) async{
  emit(HomeLoading_state(message: 'Loading...'));

}
FutureOr<void> homeLoadError_event(HomeLoadError_event event, Emitter<HomeState> emit) async{
  emit(HomeLoadError_state(error: event.error));

}

