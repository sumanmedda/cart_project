import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class API {
  // dio to fetch data from api
  final Dio _dio = Dio();

  API() {
    _dio.options.baseUrl =
        'https://fakestoreapi.com/'; // url from where data is fetched
    _dio.interceptors.add(
        PrettyDioLogger()); // this will print the fetched data from api in cosnole log
  }

  Dio get sendReq =>
      _dio; // getter is created to be used in multiple repositories
}
