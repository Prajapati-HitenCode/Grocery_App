import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:groceryapp/Data/product_model.dart';
part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<HomeInitialEvent>(homeInitialEvent);
    on<HomeLoading_event>(homeLoading_event);
    on<ProductFilter_Event>(productFilter_Event);
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
    // emit(HomeLoading_state(message: "Loading products...")); // Update message for data loading
    // await Future.delayed(Duration(seconds: 3)); // Simulate data loading delay

    QuerySnapshot snapshot = await FirebaseFirestore.instance.collection('product').get();

    // Convert the fetched documents to a list of product_model
    List<product_model> productList = snapshot.docs.map((doc) => product_model.fromDocument(doc)).toList();

    // Emit the success state with the fetched product list
    emit(HomeLoadSuccess_state(productList: productList));
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
FutureOr<void> productFilter_Event(ProductFilter_Event event, Emitter<HomeState> emit) async{

}
