import 'package:flutter/material.dart';
import 'package:flutter_sqflite_movie/app/api/controller/movie_controller.dart';
import 'package:flutter_sqflite_movie/common/helper/themes.dart';
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
                      crossAxisCount: 2, // Jumlah kolom
                      crossAxisSpacing: 8.0, // Jarak antar kolom
                      mainAxisSpacing: 8.0, // Jarak antar baris
                    ),
                    padding: const EdgeInsets.all(8.0),
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      var movie = movieController.listMovie[index];
                      return Container(
                        width: double.infinity,
                        child: Text(movie.originalTitle!, style: tsTitlePage,),
                      );
                    },
                  ),

                ),
              ),
      ),
    );
  }
}
