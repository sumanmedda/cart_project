import 'package:cart_project/model/products_list_model.dart';
import 'package:dio/dio.dart';

import 'api/api.dart';

class ProductsRepository {
  API api = API();

  Future<List<ProductsModel>> fetchProducts() async {
    try {
      Response response = await api.sendReq
          .get('/products/'); // response will store the data fetched from api
      List<dynamic> productsMaps = response.data;

      return productsMaps
          .map((productsMap) => ProductsModel.fromJson(productsMap))
          .toList();
    } catch (e) {
      rethrow;
    }
  }
}
