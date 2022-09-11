import 'package:dio/dio.dart';
import 'package:weatherapp/core/utils/consts.dart';

abstract class HttpService {
  Future<Response> getRequest(String endPoint,Map<String,dynamic>? queryParams);
  Future<Response> post(String endPoint,Map<String, dynamic> data);
}

class HttpServiceImple implements HttpService {
  late Dio _dio;

  final baseUrl = Contants.baseUrl;

  HttpServiceImple() {
    _dio = Dio(BaseOptions(
      baseUrl: baseUrl,
    ));
  }
  
  @override
  Future<Response> getRequest(String endPoint,Map<String,dynamic>? queryParams) async{
    Response response;

      try {
        if(queryParams !=null){
           response = await _dio.get(endPoint,queryParameters: queryParams);
        }else{
           response = await _dio.get(endPoint);
        }
      } on DioError catch (e) {
        print(e.message);
        throw Exception(e.message);
      }

      return response;
  }
  
  @override
  Future<Response> post(String endPoint, Map<String, dynamic> data) async{
    Response response;

      try {
        response = await _dio.post(endPoint, data: data);
      } on DioError catch (e) {
        print(e.message);
        throw Exception(e.message);
      }

      return response;
  }
}
