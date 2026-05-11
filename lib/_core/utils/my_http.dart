import 'package:dio/dio.dart';

final baseUrl = "http://192.168.0.99:8081";

final dio = Dio(
  BaseOptions(
    baseUrl: baseUrl,
    contentType: "application/json; charset=utf-8",
    validateStatus: (status) => true,
  ),
);
