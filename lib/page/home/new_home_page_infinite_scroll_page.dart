import 'package:belajar_api_movie/model/movie_top_rated_response.dart';
import 'package:belajar_api_movie/model/service/movie_service.dart';
import 'package:belajar_api_movie/page/detail_movie/detail_movie_page.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:shimmer/shimmer.dart';

class NewHomePageInfiniteScrollPage extends StatefulWidget {
  const NewHomePageInfiniteScrollPage({super.key});

  @override
  State<NewHomePageInfiniteScrollPage> createState() =>
      _NewHomePageInfiniteScrollPageState();
}

class _NewHomePageInfiniteScrollPageState
    extends State<NewHomePageInfiniteScrollPage> {
  final PagingController<int, MovieTopRatedModel> _movieListController =
      PagingController(firstPageKey: 1);

  Future<void> getMovieInfinite({
    required int page,
  }) async {
    try {
      final dataList = await MovieService.getMovieTopRated(
        page: page,
        languange: '',
      );

      bool isLastPage = dataList.results?.isEmpty == true;

      if (isLastPage) {
        _movieListController.appendLastPage(dataList.results ?? []);
      } else {
        int totalPage = page + 1;
        _movieListController.appendPage(
          dataList.results ?? [],
          totalPage,
        );
      }
    } catch (e) {
      _movieListController.error = e;
    }
  }

  @override
  void initState() {
    _movieListController.addPageRequestListener((pageKey) {
      getMovieInfinite(page: pageKey);
    });
    super.initState();
  }

  @override
  void dispose() {
    _movieListController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Infinite Movie'),
      ),
      body: RefreshIndicator(
        onRefresh: () async => _movieListController.refresh(),
        child: PagedGridView<int, MovieTopRatedModel>(
          pagingController: _movieListController,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // number of items in each row
            mainAxisSpacing: 8.0, // spacing between rows
            crossAxisSpacing: 8.0, // spacing between columns
          ),
          builderDelegate: PagedChildBuilderDelegate(
            firstPageProgressIndicatorBuilder: (context) {
              return Shimmer.fromColors(
                baseColor: Colors.grey.shade300,
                highlightColor: Colors.grey.shade100,
                child: Container(
                  color: Colors.grey,
                  height: 200,
                  width: 200,
                ),
              );
            },
            newPageProgressIndicatorBuilder: (context) {
              return Container(
                width: double.infinity,
                alignment: Alignment.center,
                child: const LinearProgressIndicator(),
              );
            },
            firstPageErrorIndicatorBuilder: (context) {
              return Column(
                children: [
                  Text('Error nih ${_movieListController.error}'),
                  ElevatedButton(
                    onPressed: () {
                      _movieListController.refresh();
                    },
                    child: const Text(
                      'Refresh',
                    ),
                  ),
                ],
              );
            },
            itemBuilder: (context, MovieTopRatedModel item, index) {
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DetailMoviePage(idMovie: item.id),
                    ),
                  );
                },
                child: CachedNetworkImage(
                  imageUrl:
                      'https://media.themoviedb.org/t/p/w220_and_h330_face/${item.posterPath}',
                  fit: BoxFit.fill,
                  placeholder: (context, url) {
                    return const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircularProgressIndicator(),
                      ],
                    );
                  },
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
