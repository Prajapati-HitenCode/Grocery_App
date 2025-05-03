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
    emit(HomeLoading_state());
    await Future.delayed(Duration(seconds: 3));
    debugPrint("Loading finished");
    emit(HomeLoadSuccess_state());
  } catch (e) {
    debugPrint("Error occurred: $e");
    emit(HomeLoadError_state(error: e.toString()));
  }
}
FutureOr<void> homeLoading_event(HomeLoading_event event, Emitter<HomeState> emit) async{
  emit(HomeLoading_state());

}
FutureOr<void> homeLoadError_event(HomeLoadError_event event, Emitter<HomeState> emit) async{
  emit(HomeLoadError_state(error: event.error));

}

