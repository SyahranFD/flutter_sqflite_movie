import 'dart:convert';
import 'dart:io';

import 'package:flutter_sqflite_movie/app/api/constant/url.dart';
import 'package:flutter_sqflite_movie/app/api/model/movie_model.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class MovieController extends GetxController {
  RxList<MovieModel> listMovie = <MovieModel>[].obs;
  final isLoading = false.obs;
  Database? database;

  @override
  void onInit() {
    // TODO: implement onInit
    fetchMovie();
    initDatabase();
    super.onInit();
  }

  Future fetchMovie() async {
    print('fetch movie dijalankan');
    try {
      listMovie.clear();
      isLoading.value = true;
      var response = await http.get(Uri.parse(baseUrl), headers: {
        'Accept': 'application/json',
      });
      if (response.statusCode == 200) {
        final content = json.decode(response.body)['results'];
        for (var item in content) {
          // listMovie.add(MovieModel.fromJson(item));
          addMovie(MovieModel.fromJson(item));
        }
        isLoading.value = false;
      } else {
        isLoading.value = false;
        print(json.decode(response.body));
      }
    } catch (e) {
      isLoading.value = false;
      print(e.toString());
    }
  }

  void initDatabase() async {
    String db_name = "db_movie";
    int db_version = 1;
    String tableMovie = "movie";
    String tableWatchlist = "watchlist";
    String id = "id";
    String original_title = "original_title";
    String title = "title";
    String backdrop_path = "backdrop_path";
    String overview = "overview";
    String popularity = "popularity";
    String poster_path = "poster_path";
    String release_date = "release_date";
    String vote_average = "vote_average";
    String vote_count = "vote_count";
    String original_language = "original_language";
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + db_name;

    database ??= await openDatabase(path, version: db_version,
        onCreate: (db, version) {
          print(path);
          db.execute('''
      CREATE TABLE IF NOT EXISTS $tableMovie (
            $backdrop_path VARCHAR(255),
            $id INTEGER PRIMARY KEY,
            $original_language VARCHAR(255),
            $original_title VARCHAR(255),
            $overview TEXT,
            $popularity DOUBLE,
            $poster_path VARCHAR(255),
            $release_date DATE,
            $title VARCHAR(255),
            $vote_average DOUBLE,
            $vote_count INTEGER
          )''');

          db.execute('''
      CREATE TABLE IF NOT EXISTS $tableWatchlist (
            $id INTEGER PRIMARY KEY,
            $original_language VARCHAR(255),
            $original_title VARCHAR(255),
            $overview TEXT,
            $popularity DOUBLE,
            $poster_path VARCHAR(255),
            $release_date DATE,
            $title VARCHAR(255),
            $vote_average DOUBLE,
            $vote_count INTEGER
          )''');
        });
  }


  void addMovie(MovieModel movie) async {
    String table = "movie";
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + "db_movie";
    database = await openDatabase(path);

    await database!.insert(table, movie.toJson());
  }

  Future<List<MovieModel>> getDataMovie() async {
    String table = "movie";
    Directory directory = await getApplicationDocumentsDirectory();
    String path = "${directory.path}db_movie";
    database = await openDatabase(path);
    final data = await database!.query(table);
    List<MovieModel> movie = data.map((e) => MovieModel.fromJson(e)).toList();
    movie.forEach((element) {
      print(element.title);
    });
    return movie;
  }
}