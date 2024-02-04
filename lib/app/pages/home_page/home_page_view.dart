import 'package:flutter/material.dart';
import 'package:flutter_sqflite_movie/app/api/controller/movie_controller.dart';
import 'package:flutter_sqflite_movie/common/helper/themes.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class HomePageView extends StatelessWidget {
  final MovieController movieController = Get.put(MovieController());

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
        title: Text("Top Rated Movie", style: tsTitlePage),
      ),
      body: Obx(
        () => movieController.isLoading.value
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Container(
                width: double.infinity,
                margin: EdgeInsets.only(top: 15, left: width * 0.05, right: width * 0.05),
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: GridView.builder(
                    itemCount: movieController.listMovie.length,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 5,
                      childAspectRatio: 0.57,
                    ),
                    padding: const EdgeInsets.only(top: 8, bottom: 100, left: 8, right: 8),
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      var movie = movieController.listMovie[index];

                      return Container(
                        width: double.infinity,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Stack(
                              children: [
                                Container(
                                  width: double.infinity,
                                  height: 250,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(3),
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
                                    borderRadius: BorderRadius.circular(3),
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

                                Align(
                                  alignment: Alignment.topRight,
                                  child: SvgPicture.asset(
                                    'assets/icons/icBookmarkAdd.svg',
                                    height: 55,
                                  ),
                                ),

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
                                          movie.voteAverage!.toStringAsFixed(1),
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
                        )
                      );
                    },
                  ),

                ),
              ),
      ),
    );
  }
}
