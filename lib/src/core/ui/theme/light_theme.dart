import 'package:flutter/material.dart';

class LightTheme {
  LightTheme._internal();

  static ThemeData get theme => ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        fontFamily: 'IBM Plex Sans',
      );
}
