import 'package:belajar_api_movie/model/detail_movie_response.dart';
import 'package:belajar_api_movie/model/movie_recommendation_response.dart';
import 'package:belajar_api_movie/model/movie_top_rated_response.dart';
import 'package:belajar_api_movie/utils/base_url.dart';
import 'package:belajar_api_movie/utils/shared_pref.dart';
import 'package:dio/dio.dart';

class MovieService {
  static Dio dio = Dio();

  static Future<DetailMovieResponse> getDetailMovie({
    required int? idMovie,
  }) async {
    try {
      final token = await SharedPref.getToken();
      final response = await dio.get(
        '${BaseUrl.baseUrl}/movie/$idMovie',
        options: Options(
          headers: {
            'Authorization': "Bearer $token",
            "Content-Type": "application/json",
          },
        ),
      );

      return DetailMovieResponse.fromJson(response.data);
    } on DioException catch (e) {
      throw e.toString();
    }
  }

  static Future<MovieTopRatedResponse> getMovieTopRated({
    String? languange,
    int? page,
  }) async {
    try {
      final token = await SharedPref.getToken();

      final response = await dio.get(
        '${BaseUrl.baseUrl}/movie/top_rated?language=$languange&page=$page',
        options: Options(
          headers: {
            'Authorization': "Bearer $token",
            "Content-Type": "application/json",
          },
        ),
      );

      return MovieTopRatedResponse.fromJson(
        response.data,
      );
    } on DioException catch (e) {
      throw e.toString();
    }
  }

  static Future<MovieRecomendationResponse> getMovieRecommendation({
    required int idMovie,
  }) async {
    try {
      final token = await SharedPref.getToken();

      final response = await dio.get(
        '${BaseUrl.baseUrl}/movie/$idMovie/recommendations',
        options: Options(
          headers: {
            'Authorization': "Bearer $token",
            "Content-Type": "application/json",
          },
        ),
      );

      return MovieRecomendationResponse.fromJson(
        response.data,
      );
    } on DioException catch (e) {
      throw e.toString();
    }
  }
}
