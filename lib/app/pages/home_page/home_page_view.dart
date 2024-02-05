import 'package:flutter/material.dart';
import 'package:flutter_sqflite_movie/app/api/controller/movie_controller.dart';
import 'package:flutter_sqflite_movie/app/api/controller/watchlist_controller.dart';
import 'package:flutter_sqflite_movie/app/api/model/movie_model.dart';
import 'package:flutter_sqflite_movie/common/helper/themes.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class HomePageView extends StatelessWidget {
  final MovieController movieController = Get.put(MovieController());
  final WatchListController watchListController =
      Get.put(WatchListController());

  @override
  Widget build(BuildContext context) {
    final Size mediaQuery = MediaQuery.of(context).size;
    final double width = mediaQuery.width;
    return Scaffold(
        backgroundColor: backgroundColor,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: backgroundColor,
          toolbarHeight: 75,
          centerTitle: true,
          automaticallyImplyLeading: false,
          title: Text("Top Rated Movie", style: tsTitlePage),
        ),
        body: Obx(
          () => movieController.isLoading.value
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : FutureBuilder<List<MovieModel>>(
                  future: movieController.getDataMovie(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Container(
                        width: double.infinity,
                        margin: EdgeInsets.only(
                            top: 15, left: width * 0.05, right: width * 0.05),
                        child: SingleChildScrollView(
                          physics: const AlwaysScrollableScrollPhysics(),
                          child: GridView.builder(
                            itemCount: snapshot.data!.length,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 12,
                              mainAxisSpacing: 5,
                              childAspectRatio: 0.57,
                            ),
                            padding: const EdgeInsets.only(
                                top: 8, bottom: 100, left: 8, right: 8),
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              var movie = snapshot.data![index];

                              return SizedBox(
                                  width: double.infinity,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Stack(
                                        children: [
                                          Container(
                                            width: double.infinity,
                                            height: 250,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(3),
                                              image: DecorationImage(
                                                image: NetworkImage(
                                                  'https://image.tmdb.org/t/p/w500${movie.posterPath}',
                                                ),
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                          Container(
                                            width: double.infinity,
                                            height: 250,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(3),
                                              gradient: LinearGradient(
                                                begin: Alignment.bottomCenter,
                                                end: const Alignment(0, 0.4),
                                                colors: [
                                                  Colors.black.withOpacity(0.8),
                                                  Colors.transparent,
                                                ],
                                              ),
                                            ),
                                          ),
                                          Obx(() {
                                            bool isSelected = watchListController.isSelected(movie.id!);
                                            return isSelected
                                                ? InkWell(
                                                    onTap: () {
                                                      watchListController.deleteData(movie.id!);
                                                      watchListController.isSelected(movie.id!);
                                                    },
                                                    child: Align(
                                                      alignment: Alignment.topRight,
                                                      child: SvgPicture.asset(
                                                        'assets/icons/icBookmarkSelected.svg',
                                                        height: 55,
                                                      ),
                                                    ),
                                                  )
                                                : InkWell(
                                                    onTap: () {
                                                      watchListController.addWatchlist(movie);
                                                      watchListController.isSelected(movie.id!);
                                                    },
                                                    child: Align(
                                                      alignment: Alignment.topRight,
                                                      child: SvgPicture.asset(
                                                        'assets/icons/icBookmarkAdd.svg',
                                                        height: 55,
                                                      ),
                                                    ),
                                                  );
                                          }),
                                          Positioned(
                                            bottom: 10,
                                            left: 10,
                                            child: Align(
                                              alignment: Alignment.bottomLeft,
                                              child: Row(
                                                children: [
                                                  const Icon(
                                                    Icons.star_rounded,
                                                    color: Colors.yellow,
                                                    size: 20,
                                                  ),
                                                  const SizedBox(width: 5),
                                                  Text(
                                                    movie.voteAverage!
                                                        .toStringAsFixed(1),
                                                    style: tsRating,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                      const SizedBox(height: 5),
                                      Text(
                                        movie.title!,
                                        style: tsTitleMovie,
                                        textAlign: TextAlign.left,
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 2,
                                      ),
                                    ],
                                  ));
                            },
                          ),
                        ),
                      );
                    } else {
                      return const Center(
                        child: Text("Tidak Ada Data"),
                      );
                    }
                  }),
        ),
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: backgroundColor,
          selectedItemColor: primaryColor,
          unselectedItemColor: greyColor,
          onTap: (index) {
            if (index == 0) {
              Get.toNamed('/');
            } else {
              watchListController.getWatchlist();
              Get.toNamed('/watchlist');
            }
          },
          currentIndex: 0,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.movie_creation_outlined),
              label: 'Movie',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.bookmark_border_outlined),
              label: 'Watchlist',
            ),
          ],
        ));
  }
}
