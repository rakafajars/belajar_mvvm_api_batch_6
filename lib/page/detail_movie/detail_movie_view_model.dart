import 'package:belajar_api_movie/model/movie_recommendation_response.dart';
import 'package:belajar_api_movie/model/service/movie_service.dart';
import 'package:flutter/material.dart';

class DetailMovieViewModel extends ChangeNotifier {
  MovieRecomendationResponse _movieRecomendationResponse =
      MovieRecomendationResponse();
  MovieRecomendationResponse get movieRecomendationResponse =>
      _movieRecomendationResponse;

  bool _isLoadingMovieRecommendation = false;
  bool get isLoadingMovieRecommendation => _isLoadingMovieRecommendation;

  String? _errorMovieRecommendation;
  String? get errorMovieRecommendation => _errorMovieRecommendation;

  void getMovieRecommendation({
    required idMovie,
  }) async {
    _isLoadingMovieRecommendation = true;
    _movieRecomendationResponse = MovieRecomendationResponse();
    _errorMovieRecommendation = null;
    notifyListeners();
    try {
      final response = await MovieService.getMovieRecommendation(
        idMovie: idMovie,
      );

      _movieRecomendationResponse = response;
      notifyListeners();
    } catch (e) {
      _errorMovieRecommendation = e.toString();
      notifyListeners();
    } finally {
      _isLoadingMovieRecommendation = false;
      notifyListeners();
    }
  }
}
