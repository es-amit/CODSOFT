
import 'package:d_quotes/screen/home_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

// ignore: must_be_immutable
class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late ThemeData _theme;
  @override
  void initState() {
    _theme = darkTheme();
    super.initState();
  }


  void updateTheme(BuildContext context) {
    final Brightness platformBrightness = MediaQuery.of(context).platformBrightness;
    if (platformBrightness == Brightness.dark) {
      setState(() {
        _theme = darkTheme();
      });
    } else {
      setState(() {
        _theme = lightTheme();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: _theme,
      themeMode: ThemeMode.system,
      debugShowCheckedModeBanner: false,
      home: const HomeScreen(),
    );
  }

  ThemeData darkTheme(){
    return ThemeData.dark(
    useMaterial3: true,
  ).copyWith(
    appBarTheme: const AppBarTheme(
      centerTitle: true,
      color: Colors.lightBlue,
      titleTextStyle: TextStyle(
        color: Colors.black,
        letterSpacing: 0.8,
        fontSize: 24,
        fontWeight: FontWeight.bold
      )
    ),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(
        color: Colors.white,
        fontSize: 28,
        fontWeight: FontWeight.w700,
        letterSpacing: 0.7,
        fontStyle: FontStyle.italic
      ),
      bodySmall: TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.w500,
        color: Colors.white,
        letterSpacing: 0.5
      ),
      titleLarge: TextStyle(
        color: Colors.white,
        fontSize: 37,
        fontWeight: FontWeight.w700,
        fontStyle: FontStyle.italic,
        letterSpacing: 1
      ),
      displayMedium: TextStyle(
        color: Colors.black87,
        fontWeight: FontWeight.bold,
        letterSpacing: 1,
        fontSize: 25
      ),
      displaySmall: TextStyle(
        color: Colors.black38,
        fontWeight: FontWeight.w600,
        letterSpacing: 1,
        fontSize: 18
      ),
    ),
    iconTheme: const IconThemeData(
      color: Colors.black,
      size: 32,
    )
  );
  }

  ThemeData lightTheme(){
    return ThemeData.light(
    useMaterial3: true,
  ).copyWith(
    appBarTheme: const AppBarTheme(
      color: Colors.lightBlue,
      centerTitle: true,
      titleTextStyle: TextStyle(
        color: Colors.black,
        letterSpacing: 0.8,
        fontSize: 24,
        fontWeight: FontWeight.bold
      )
    ),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(
        color: Colors.white,
        fontSize: 28,
        fontWeight: FontWeight.w700,
        letterSpacing: 0.7,
        fontStyle: FontStyle.italic
      ),
      bodySmall: TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.w500,
        color: Colors.white,
        letterSpacing: 0.5
      ),
      titleLarge: TextStyle(
        color: Colors.white,
        fontSize: 37,
        fontWeight: FontWeight.w700,
        fontStyle: FontStyle.italic,
        letterSpacing: 1
      ),
      displayMedium: TextStyle(
        color: Colors.black87,
        fontWeight: FontWeight.bold,
        letterSpacing: 1,
        fontSize: 25
      ),
      displaySmall: TextStyle(
        color: Colors.black38,
        fontWeight: FontWeight.w600,
        letterSpacing: 1,
        fontSize: 18
      ),
    ),
    iconTheme: const IconThemeData(
      color: Colors.black,
      size: 32,
    )
  );
  }
}

