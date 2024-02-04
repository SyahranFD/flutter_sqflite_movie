import 'dart:convert';
import 'dart:io';

import 'package:flutter_sqflite_movie/app/api/constant/url.dart';
import 'package:flutter_sqflite_movie/app/api/model/movie_model.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class WatchListController extends GetxController {
  final isLoading = false.obs;
  Database? database;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  void addWatchlist(MovieModel movie) async {
    String table = "watchlist";
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + "db_movie";
    database = await openDatabase(path);

    await database!.insert(table, movie.toJson());
  }

  Future<List<MovieModel>> getWatchlist() async {
    String table = "watchlist";
    Directory directory = await getApplicationDocumentsDirectory();
    String path = "${directory.path}db_movie";
    database = await openDatabase(path);
    final data = await database!.query(table);
    List<MovieModel> movie = data.map((e) => MovieModel.fromJson(e)).toList();
    return movie;
  }

  Future<void> delete(int id) async {
    String table = "watchlist";
    Directory directory = await getApplicationDocumentsDirectory();
    String path = "${directory.path}db_movie";
    database = await openDatabase(path);
    await database!.delete(table, where: "id = ?", whereArgs: [id]);
  }
}