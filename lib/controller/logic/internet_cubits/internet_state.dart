// bloc cubits performs when events are occured
import 'package:cart_project/model/products_list_model.dart';

abstract class InternetState {}

class InternetLoadingState extends InternetState {}

class InternetGainedState extends InternetState {
  final List<ProductsModel> products;
  InternetGainedState(this.products);
}

class InternetLostState extends InternetState {
  final String error;

  InternetLostState(
    this.error,
  );
}
