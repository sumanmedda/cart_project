import '../../../model/products_list_model.dart';

// bloc cubits performs when events are occured
abstract class ProductsState {}

class ProductsLoadingState extends ProductsState {}

class ProductsLoadedState extends ProductsState {
  final List<ProductsModel> products;
  ProductsLoadedState(this.products);
}

class ProductsErrorState extends ProductsState {
  final String error;
  ProductsErrorState(this.error);
}
