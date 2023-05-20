import 'dart:async';

import 'package:cart_project/model/products_list_model.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../repositories/products_repository.dart';
import 'internet_state.dart';

class InternetCubit extends Cubit<InternetState> {
  final Connectivity _connectivity =
      Connectivity(); //it is used to check network connectivity
  StreamSubscription? connectivitySubscription;
  ProductsRepository productsRepository =
      ProductsRepository(); // used to get fetchProducts function from products repository

  InternetCubit() : super(InternetLoadingState()) {
    connectivitySubscription =
        _connectivity.onConnectivityChanged.listen((result) async {
      if (result == ConnectivityResult.mobile ||
          result == ConnectivityResult.wifi) {
        List<ProductsModel> products = await productsRepository.fetchProducts();
        emit(InternetGainedState(
            products)); // if internet is connected then InternetGainedState will be emited
      } else {
        emit(InternetLostState(
            'Not Connected To Internet')); // if internet is not connected then InternetLostState will be emited
      }
    });
  }

  // after connectivity close function is used to cancel the connectivitySubscription
  @override
  Future<void> close() {
    connectivitySubscription?.cancel();
    return super.close();
  }
}
