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
      isLoading.value = true;
      var response = await http.get(Uri.parse(baseUrl), headers: {
        'Accept': 'application/json',
      });
      if (response.statusCode == 200) {
        deleteAllData();
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
    String dbName = "db_movie";
    int dbVersion = 1;
    String tableMovie = "movie";
    String tableWatchlist = "watchlist";
    String id = "id";
    String originalTitle = "original_title";
    String title = "title";
    String backdropPath = "backdrop_path";
    String overview = "overview";
    String popularity = "popularity";
    String posterPath = "poster_path";
    String releaseDate = "release_date";
    String voteAverage = "vote_average";
    String voteCount = "vote_count";
    String originalLanguage = "original_language";
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + dbName;

    database ??= await openDatabase(path, version: dbVersion,
        onCreate: (db, version) {
          print(path);
          db.execute('''
      CREATE TABLE IF NOT EXISTS $tableMovie (
            $backdropPath VARCHAR(255),
            $id INTEGER,
            $originalLanguage VARCHAR(255),
            $originalTitle VARCHAR(255),
            $overview TEXT,
            $popularity DOUBLE,
            $posterPath VARCHAR(255),
            $releaseDate DATE,
            $title VARCHAR(255),
            $voteAverage DOUBLE,
            $voteCount INTEGER
          )''');

          db.execute('''
      CREATE TABLE IF NOT EXISTS $tableWatchlist (
            $backdropPath VARCHAR(255),
            $id INTEGER,
            $originalLanguage VARCHAR(255),
            $originalTitle VARCHAR(255),
            $overview TEXT,
            $popularity DOUBLE,
            $posterPath VARCHAR(255),
            $releaseDate DATE,
            $title VARCHAR(255),
            $voteAverage DOUBLE,
            $voteCount INTEGER
          )''');
        });
  }


  void addMovie(MovieModel movie) async {
    String table = "movie";
    Directory directory = await getApplicationDocumentsDirectory();
    String path = "${directory.path}db_movie";
    database = await openDatabase(path);

    await database!.insert(table, movie.toJson());
  }

  Future<void> deleteAllData() async {
    String table = "movie";
    Directory directory = await getApplicationDocumentsDirectory();
    String path = "${directory.path}db_movie";
    database = await openDatabase(path);

    await database!.delete(table);
  }

  Future<List<MovieModel>> getDataMovie() async {
    String table = "movie";
    Directory directory = await getApplicationDocumentsDirectory();
    String path = "${directory.path}db_movie";
    database = await openDatabase(path);
    final data = await database!.query(table);
    List<MovieModel> movie = data.map((e) => MovieModel.fromJson(e)).toList();
    for (var element in movie) {
      print(element.title);
    }
    return movie;
  }
}