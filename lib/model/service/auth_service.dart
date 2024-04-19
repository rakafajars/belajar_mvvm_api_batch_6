import 'package:belajar_api_movie/model/request_login_model.dart';
import 'package:belajar_api_movie/utils/shared_pref.dart';
import 'package:dio/dio.dart';

class AuthService {
  static Dio dio = Dio();

  static Future<void> postLogin({
    required RequestLoginModel requestLoginModel,
  }) async {
    try {
      final response = await dio.post(
        'https://fakestoreapi.com/auth/login',
        data: requestLoginModelToJson(
          requestLoginModel,
        ),
      );

      if (response.statusCode == 200) {
        // String token = response.data["token"];

        // SharedPref.saveToken(token);
        // hardcode token dengan token move
        SharedPref.saveToken(
          'eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIwYjBkZWJlMDUzNTM1NGZkNDViM2I4NmE4MWZkMzVhMiIsInN1YiI6IjVlNjk5ZGU4Y2VkYWM0MDAxNTQ2YmMyYyIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.X6XeWeTtRu1bibtfYujUyi_m0bdVmwK8bFastHyZVfk',
        );
      }
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        throw e.response?.data;
      } else if (e.response?.statusCode == 400) {
        if (e.response?.data ==
            "username and password are not provided in JSON format") {
          throw 'Username atau password tidak boleh kosong';
        } else {
          throw 'Terjadi Kesalahan!';
        }
      } else {
        throw 'Terjadi Kesalahan!';
      }
    }
  }
}
