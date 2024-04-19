import 'package:belajar_api_movie/model/movie_top_rated_response.dart';
import 'package:belajar_api_movie/model/service/movie_service.dart';
import 'package:belajar_api_movie/page/detail_movie/detail_movie_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _isLoadingListMovie = false;
  String? errorMovie;
  List<MovieTopRatedModel> listMovieTopRated = [];

  int _initialPage = 1;

  void initMovie({required int page}) async {
    _isLoadingListMovie = true;
    errorMovie = null;
    listMovieTopRated.clear();

    setState(() {});
    try {
      final data = await MovieService.getMovieTopRated(
        page: page,
        languange: '',
      );

      listMovieTopRated = data.results ?? [];
      setState(() {});
    } catch (e) {
      errorMovie = e.toString();
      setState(() {});
    } finally {
      _isLoadingListMovie = false;
      setState(() {});
    }
  }

  Widget bodyMovie() {
    if (_isLoadingListMovie) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    } else if (errorMovie != null) {
      return Center(
        child: Text(errorMovie ?? "-"),
      );
    } else {
      return Column(
        children: [
          SizedBox(
            height: 100,
            child: ListView.builder(
              itemCount: 10,
              padding: const EdgeInsets.only(
                left: 24,
              ),
              scrollDirection: Axis.horizontal,
              itemBuilder: (contex, int index) {
                int total = index + 1;
                return Padding(
                  padding: const EdgeInsets.only(right: 16),
                  child: GestureDetector(
                    onTap: () {
                      _initialPage = total;
                      initMovie(page: _initialPage);
                      setState(() {});
                    },
                    child: Container(
                      color: _initialPage == total ? Colors.blue : null,
                      child: Text(
                        "${index + 1}",
                        style: const TextStyle(
                          fontSize: 36,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Expanded(
            child: GridView.builder(
              itemCount: listMovieTopRated.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // number of items in each row
                mainAxisSpacing: 8.0, // spacing between rows
                crossAxisSpacing: 8.0, // spacing between columns
              ),
              itemBuilder: (context, int index) {
                var data = listMovieTopRated[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailMoviePage(idMovie: data.id),
                      ),
                    );
                  },
                  child: Image.network(
                    'https://media.themoviedb.org/t/p/w220_and_h330_face/${data.posterPath}',
                    fit: BoxFit.fill,
                  ),
                );
              },
            ),
          ),
        ],
      );
    }
  }

  @override
  void initState() {
    initMovie(
      page: _initialPage,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Home',
        ),
      ),
      body: bodyMovie(),
    );
  }
}
