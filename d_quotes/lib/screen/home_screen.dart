import 'dart:convert';

import 'package:d_quotes/models/quote.dart';
import 'package:d_quotes/screen/detail_screen.dart';
import 'package:d_quotes/screen/favorite_screen.dart';
import 'package:d_quotes/widgets/quote_tile.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:lottie/lottie.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Quote> quoteList = [];
  String baseUrl =
      "https://api.quotable.io/quotes/random?limit=140?minLength=20&maxLength=120";

  Future<List<Quote>> getquoteApi(String url) async {
    final response = await http.get(Uri.parse(baseUrl));
    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      quoteList.clear();
      for (Map<String, dynamic> i in data) {
        quoteList.add(Quote.fromJson(i));
      }
      return quoteList;
    }
    return quoteList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home Screen"),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const FavoriteScreen()));
              },
              icon: const Icon(
                Icons.favorite_rounded,
                color: Colors.red,
                size: 30,
              ))
        ],
      ),
      body: FutureBuilder(
          future: getquoteApi(baseUrl),
          builder: (context, AsyncSnapshot<List<Quote>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: Lottie.asset(
                  'animation/loading.json',
                  height: 250,
                  repeat: true
                ), // Show a loading indicator
              );
            }
            else {
              return ListView.builder(
                  itemCount: quoteList.length,
                  itemBuilder: ((context, index) {
                    String author = snapshot.data![index].author!;
                    String content = snapshot.data![index].content!;
                    return QuotesTile(
                        author: author,
                        content: content,
                        nextScreen: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => QuoteDetailScreen(
                                        id: snapshot.data![index].sId!,
                                        author: author,
                                        content: content,
                                      )));
                        });
                  }));
            }
          }),
    );
  }
}
