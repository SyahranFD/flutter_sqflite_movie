import 'package:flutter/material.dart';
import 'package:flutter_sqflite_movie/app/global_component/navbar.dart';
import 'package:flutter_sqflite_movie/common/routes/app_pages.dart';
import 'package:get/get.dart';

void main() async {
  runApp(
    GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Application",
        theme: ThemeData(
          appBarTheme: const AppBarTheme(
            iconTheme: IconThemeData(color: Colors.black),
          ),
        ),
        initialRoute: AppPages.INITIAL,
        getPages: AppPages.routes,
    ),
  );
}
