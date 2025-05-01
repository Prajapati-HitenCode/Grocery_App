import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:groceryapp/Data/product_model.dart';
import 'package:meta/meta.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<HomeEvent>((event, emit) {
    });
    on<HomeInitialEvent>(homeInitialEvent);
  }
}
FutureOr<void> homeInitialEvent(HomeInitialEvent event, Emitter<HomeState> emit) async{
  try
      {
        emit(HomeLoading_state());
        await Future.delayed(Duration(seconds: 3));
        emit(HomeLoadSuccess_state(productList: []));
      }
      catch(e)
      {
        emit(HomeLoadError_state(error: e.toString()));
      }

}

