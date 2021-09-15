import 'package:flutter/material.dart';
import 'package:news_feed/Presintation/Screens/news_feed.dart';
import 'package:news_feed/Shared/styles.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      primarySwatch: Colors.blue,
      visualDensity: VisualDensity.adaptivePlatformDensity,
      scaffoldBackgroundColor: MainColors.scaffold,
    ),
    home: NewsFeed(),
  ));
}
