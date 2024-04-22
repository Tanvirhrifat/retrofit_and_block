import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';
import 'user.dart';  // Reference to your data model

part 'api_service.g.dart';

@RestApi(baseUrl: 'https://jsonplaceholder.typicode.com/')
abstract class ApiService {
  factory ApiService(Dio dio, {String baseUrl}) = _ApiService;

  @GET('/users')
  Future<List<User>> getUsers();
}
