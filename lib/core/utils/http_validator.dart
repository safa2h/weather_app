import 'package:dio/dio.dart';
import 'package:weatherapp/core/utils/exception.dart';

mixin HttpValidator {
  void responseValidator(Response response) {
    if (response.statusCode != 200) {
      throw AppException('unknown error ');
    }
  }
}
