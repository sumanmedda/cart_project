import 'package:cart_project/controller/logic/products_cubit/prducts_state.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../model/products_list_model.dart';
import '../../repositories/products_repository.dart';

class ProductsCubit extends Cubit<ProductsState> {
  ProductsCubit() : super(ProductsLoadingState()) {
    fetchProducts();
  }

  ProductsRepository productsRepository =
      ProductsRepository(); // used to get fetchProducts function from products repository

  fetchProducts() async {
    try {
      List<ProductsModel> products = await productsRepository.fetchProducts();
      emit(ProductsLoadedState(
          products)); // when app is loaded products data is sent to ProductsLoadedState
    } on DioError catch (e) {
      emit(ProductsErrorState(e.message
          .toString())); // if something wrong happens this will print out the issue
    }
  }
}
