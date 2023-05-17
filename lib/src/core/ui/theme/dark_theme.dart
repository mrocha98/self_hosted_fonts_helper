import 'package:flutter/material.dart';

class DarkTheme {
  DarkTheme._internal();

  static ThemeData get theme => ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
          brightness: Brightness.dark,
        ),
        fontFamily: 'IBM Plex Sans',
      );
}
