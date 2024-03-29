import 'dart:io';

import 'package:flutter_sqflite_movie/app/api/model/movie_model.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class WatchListController extends GetxController {
  Database? database;
  RxList<MovieModel> listWatchlist = <MovieModel>[].obs;

  @override
  void onInit() {
    getWatchlist();
    super.onInit();
  }

  void addWatchlist(MovieModel movie) async {
    String table = "watchlist";
    Directory directory = await getApplicationDocumentsDirectory();
    String path = "${directory.path}db_movie";
    database = await openDatabase(path);

    final existingMovies = await database!.query(
      table,
      where: "id = ?",
      whereArgs: [movie.id],
    );

    if (existingMovies.isNotEmpty) {
      await database!.delete(
        table,
        where: "id = ?",
        whereArgs: [movie.id],
      );
    }

    await database!.insert(table, movie.toJson());
    await getWatchlist();

    listWatchlist.add(movie);
  }

  Future<List<MovieModel>> getWatchlist() async {
    String table = "watchlist";
    Directory directory = await getApplicationDocumentsDirectory();
    String path = "${directory.path}db_movie";
    database = await openDatabase(path);

    final data = await database!.query(table);
    List<MovieModel> movie = data.map((e) => MovieModel.fromJson(e)).toList();
    listWatchlist.clear();
    listWatchlist.value = movie;
    return movie;
  }

  bool isSelected(int id) {
    return listWatchlist.any((element) => element.id == id);
  }

  Future<void> deleteData(int id) async {
    String table = "watchlist";
    Directory directory = await getApplicationDocumentsDirectory();
    String path = "${directory.path}db_movie";
    database = await openDatabase(path);

    await database!.delete(table, where: "id = ?", whereArgs: [id]);
    await getWatchlist();

    listWatchlist.removeWhere((element) => element.id == id);
  }
}