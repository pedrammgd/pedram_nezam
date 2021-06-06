import 'package:dio/dio.dart';

class BackendConfig{

  static Dio dio = Dio(BaseOptions(baseUrl: 'http://10.0.2.2:3000'));
}