import 'dart:io';

import 'package:d_quotes/database/database.dart';
import 'package:d_quotes/models/favorite_quote.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';

class QuoteDetailScreen extends StatefulWidget {
  const QuoteDetailScreen({super.key,required this.id,required this.author,required this.content});

  final String content;
  final String author;
  final String id;

  @override
  State<QuoteDetailScreen> createState() => _QuoteDetailScreenState();
}

class _QuoteDetailScreenState extends State<QuoteDetailScreen> {

  final _screenshotController = ScreenshotController();
  bool isFavoriteQuote = false;
  DBHelper dbHelper = DBHelper();


  void showSnackbar(String msg){
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
       SnackBar(
        content: Text(msg),
        duration: const Duration(milliseconds: 2000),
        
      )
    );
  }

  void insertFavorite(){
    try{
      dbHelper.insert(FavoriteQuote(
        id: widget.id, 
        content: widget.content, 
        author: widget.author, 
        isFavorite: true
        )
      );
      showSnackbar("Quotes Favorited!");
    }
    catch(e){
      // error occured
    }
  }
  void removeFavorite(){
    try{
      dbHelper.delete(widget.id);
      showSnackbar("Quote Deleted!");
    }
    catch(e){
      //error occured
    }
  }

  void _takeScreenshot() async {
	  final uint8List = await _screenshotController.capture();
	  String tempPath = (await getTemporaryDirectory()).path;
	  File file = File('$tempPath/image.png');
	  await file.writeAsBytes(uint8List!);
	  // ignore: deprecated_member_use
	  await Share.shareFiles([file.path]);
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Quote Detail"),
      ),
      body: Center(
        child: Screenshot(
          controller: _screenshotController,
          child: Container(
            padding: const EdgeInsets.fromLTRB(15, 15, 15, 15),
            height: MediaQuery.of(context).size.height * 0.8,
            width: MediaQuery.of(context).size.width *0.9,
            decoration: BoxDecoration(
              color: Colors.green,
              borderRadius: BorderRadius.circular(50)
            ),
            child: Column(
              children: [
                Image.asset('assets/quote.png',
                  height: 50,),
                const SizedBox(height: 20,),
                Text(widget.content,
                  style: Theme.of(context).textTheme.titleLarge,),
                const SizedBox(height: 20,),
                Text(widget.author,
                  style: Theme.of(context).textTheme.bodySmall,),
                const Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      onPressed: () async {
                        setState(()  {
                          isFavoriteQuote = !isFavoriteQuote;
                        });
                        if(isFavoriteQuote){
                          
                          insertFavorite();
                        }
                        else{
                          removeFavorite();
                        }
                      },
                      icon: isFavoriteQuote ? const Icon(Icons.favorite_rounded, color: Colors.redAccent,) 
                        : const Icon(Icons.favorite_border_rounded, color: Colors.white,)
                         
                    ),
                    const SizedBox(width: 15,),
                    InkWell(
                      onTap: () async{
                        try{
                          _takeScreenshot();
                        }
                        catch(e){
                          print(e.toString());
                        }
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(13)
                        ),
                        height: 45,
                        width: 110,
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.share),
                            SizedBox(width: 10,),
                            Text("Share",
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                              letterSpacing: 1
                            ),)
                          ]
                        ),
                      ),
                    )
                  ],
                )
                
              ],
            ),
          ),
        ),
      ),
    );
  }
}