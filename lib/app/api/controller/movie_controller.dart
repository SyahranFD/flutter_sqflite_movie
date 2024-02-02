import 'dart:convert';

import 'package:flutter_sqflite_movie/app/api/constant/url.dart';
import 'package:flutter_sqflite_movie/app/api/model/movie_model.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class MovieController extends GetxController {
  RxList<MovieModel> listMovie = <MovieModel>[].obs;
  final isLoading = false.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    fetchMovie();
    super.onInit();
  }

  Future fetchMovie() async {
    print('fetch tagihan akan datang dijalankan');
    try {
      listMovie.clear();
      isLoading.value = true;
      var response = await http.get(Uri.parse(baseUrl), headers: {
        'Accept': 'application/json',
      });
      if (response.statusCode == 200) {
        final content = json.decode(response.body)['results'];
        for (var item in content) {
          listMovie.add(MovieModel.fromJson(item));
        }
        isLoading.value = false;
        print('berhasil fetch movie');
        for (var movie in listMovie) {
          print(movie.toJson());
        }
      } else {
        isLoading.value = false;
        print(json.decode(response.body));
      }
    } catch (e) {
      isLoading.value = false;
      print(e.toString());
    }
  }
}