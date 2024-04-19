// To parse this JSON data, do
//
//     final movieRecomendationResponse = movieRecomendationResponseFromJson(jsonString);

import 'dart:convert';

MovieRecomendationResponse movieRecomendationResponseFromJson(String str) => MovieRecomendationResponse.fromJson(json.decode(str));

String movieRecomendationResponseToJson(MovieRecomendationResponse data) => json.encode(data.toJson());

class MovieRecomendationResponse {
    int? page;
    List<MovieRecommendationModel>? results;
    int? totalPages;
    int? totalResults;

    MovieRecomendationResponse({
        this.page,
        this.results,
        this.totalPages,
        this.totalResults,
    });

    factory MovieRecomendationResponse.fromJson(Map<String, dynamic> json) => MovieRecomendationResponse(
        page: json["page"],
        results: json["results"] == null ? [] : List<MovieRecommendationModel>.from(json["results"]!.map((x) => MovieRecommendationModel.fromJson(x))),
        totalPages: json["total_pages"],
        totalResults: json["total_results"],
    );

    Map<String, dynamic> toJson() => {
        "page": page,
        "results": results == null ? [] : List<dynamic>.from(results!.map((x) => x.toJson())),
        "total_pages": totalPages,
        "total_results": totalResults,
    };
}

class MovieRecommendationModel {
    String? backdropPath;
    int? id;
    String? originalTitle;
    String? overview;
    String? posterPath;
    String? mediaType;
    bool? adult;
    String? title;
    String? originalLanguage;
    List<int>? genreIds;
    double? popularity;
    DateTime? releaseDate;
    bool? video;
    double? voteAverage;
    int? voteCount;

    MovieRecommendationModel({
        this.backdropPath,
        this.id,
        this.originalTitle,
        this.overview,
        this.posterPath,
        this.mediaType,
        this.adult,
        this.title,
        this.originalLanguage,
        this.genreIds,
        this.popularity,
        this.releaseDate,
        this.video,
        this.voteAverage,
        this.voteCount,
    });

    factory MovieRecommendationModel.fromJson(Map<String, dynamic> json) => MovieRecommendationModel(
        backdropPath: json["backdrop_path"],
        id: json["id"],
        originalTitle: json["original_title"],
        overview: json["overview"],
        posterPath: json["poster_path"],
        mediaType: json["media_type"],
        adult: json["adult"],
        title: json["title"],
        originalLanguage: json["original_language"],
        genreIds: json["genre_ids"] == null ? [] : List<int>.from(json["genre_ids"]!.map((x) => x)),
        popularity: json["popularity"]?.toDouble(),
        releaseDate: json["release_date"] == null ? null : DateTime.parse(json["release_date"]),
        video: json["video"],
        voteAverage: json["vote_average"]?.toDouble(),
        voteCount: json["vote_count"],
    );

    Map<String, dynamic> toJson() => {
        "backdrop_path": backdropPath,
        "id": id,
        "original_title": originalTitle,
        "overview": overview,
        "poster_path": posterPath,
        "media_type": mediaType,
        "adult": adult,
        "title": title,
        "original_language": originalLanguage,
        "genre_ids": genreIds == null ? [] : List<dynamic>.from(genreIds!.map((x) => x)),
        "popularity": popularity,
        "release_date": "${releaseDate!.year.toString().padLeft(4, '0')}-${releaseDate!.month.toString().padLeft(2, '0')}-${releaseDate!.day.toString().padLeft(2, '0')}",
        "video": video,
        "vote_average": voteAverage,
        "vote_count": voteCount,
    };
}
