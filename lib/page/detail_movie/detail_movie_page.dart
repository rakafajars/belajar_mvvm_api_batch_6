import 'package:belajar_api_movie/model/detail_movie_response.dart';
import 'package:belajar_api_movie/model/service/movie_service.dart';
import 'package:belajar_api_movie/page/detail_movie/detail_movie_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DetailMoviePage extends StatefulWidget {
  final int? idMovie;
  const DetailMoviePage({super.key, required this.idMovie});

  @override
  State<DetailMoviePage> createState() => _DetailMoviePageState();
}

class _DetailMoviePageState extends State<DetailMoviePage> {
  bool _isLoadingDetail = false;
  String? errorDetailMvoie;
  DetailMovieResponse? detailMovieResponse;

  void getDetailMovie() async {
    _isLoadingDetail = true;
    errorDetailMvoie = null;
    detailMovieResponse = null;
    setState(() {});
    try {
      final data = await MovieService.getDetailMovie(
        idMovie: widget.idMovie,
      );
      detailMovieResponse = data;
      setState(() {});
    } catch (e) {
      errorDetailMvoie = e.toString();
      setState(() {});
    } finally {
      _isLoadingDetail = false;
      setState(() {});
    }
  }

  @override
  void initState() {
    getDetailMovie();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<DetailMovieViewModel>(context, listen: false)
          .getMovieRecommendation(
        idMovie: widget.idMovie,
      );
    });
    super.initState();
  }

  Widget recomendationWidget() {
    return Consumer<DetailMovieViewModel>(
      builder: (context, DetailMovieViewModel viewModel, child) {
        if (viewModel.isLoadingMovieRecommendation) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (viewModel.errorMovieRecommendation != null) {
          return Center(
            child: Text(viewModel.errorMovieRecommendation!),
          );
        } else {
          return SizedBox(
            height: 100,
            child: ListView.builder(
              itemCount:
                  viewModel.movieRecomendationResponse.results?.length ?? 0,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, int index) {
                var data = viewModel.movieRecomendationResponse.results?[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            DetailMoviePage(idMovie: data?.id),
                      ),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(
                      right: 16,
                    ),
                    child: SizedBox(
                      height: 100,
                      width: 100,
                      child: Image.network(
                        'https://media.themoviedb.org/t/p/w220_and_h330_face/${data?.backdropPath}',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                );
              },
            ),
          );
        }
      },
    );
  }

  Widget bodyDetail() {
    if (_isLoadingDetail) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    } else if (errorDetailMvoie != null) {
      return Center(
        child: Text(errorDetailMvoie ?? "-"),
      );
    } else {
      return SingleChildScrollView(
        padding: const EdgeInsets.only(
          bottom: 16,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              'https://media.themoviedb.org/t/p/w220_and_h330_face/${detailMovieResponse?.posterPath}',
              height: 700,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            Text(
              detailMovieResponse?.originalTitle ?? "-",
            ),
            Text(
              detailMovieResponse?.overview ?? "-",
            ),
            Text('Release Date : ${detailMovieResponse?.releaseDate}'),
            recomendationWidget(),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Detail Movie ${widget.idMovie}',
        ),
      ),
      body: bodyDetail(),
    );
  }
}
