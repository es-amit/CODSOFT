
import 'package:d_quotes/database/database.dart';
import 'package:d_quotes/models/favorite_quote.dart';
import 'package:flutter/material.dart';
import 'package:random_color/random_color.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
   DBHelper? dbHelper;
  late Future<List<FavoriteQuote>> allFavorites;
  late PageController _pageController;
  int currentPage = 0;
  final RandomColor _randomColor  = RandomColor(
  );
  @override
  void initState() {
    super.initState();
    dbHelper = DBHelper();
    loadData();
    _pageController = PageController(initialPage: currentPage,viewportFraction: 0.8);
  }

  void showSnackbar(String msg){
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
       SnackBar(
        content: Text(msg),
        duration: const Duration(milliseconds: 2000),
        
      )
    );
  }


  loadData() async{
    allFavorites = dbHelper!.getDataList();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        title: const Text("Your Favorites"),
      ),
      body: FutureBuilder(
        future: allFavorites, 
        builder: (context,AsyncSnapshot<List<FavoriteQuote>> snapshot){
          if(!snapshot.hasData){
            return const CircularProgressIndicator(
              color: Colors.blueAccent,
            );
          }
          else if(snapshot.data!.isEmpty){
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 20),
              child: Center(
                child: Column(
                  children: [
                    Image.asset('assets/heart.jpg',
                      width: 300,
                      height: 300,
                    ),
                    
                    const SizedBox(height: 20,),
              
                    Text("No Favorites Yet",
                      style: Theme.of(context).textTheme.displayMedium,),
                    const SizedBox(height: 15,),
                    Text("You can add an item to your favourites by clicking 'Favorite Icon'",
                      textAlign:  TextAlign.center,
                      style: Theme.of(context).textTheme.displaySmall,),
                    const SizedBox(height: 25,),
                    InkWell(
                      borderRadius: BorderRadius.circular(30),
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.08,
                        width: MediaQuery.of(context).size.width * 0.35,
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 33, 107, 243),
                          borderRadius: BorderRadius.circular(30)
                        ),
                        child: const Center(
                          child: Text("Go Back",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                              fontSize: 18,
                              letterSpacing: 1
                            ),),
                        ),
                      ),
                    )
                  ],
                )
              ),
            );

          }
          else{
            return PageView.builder(
              itemCount: snapshot.data!.length,
              physics: const ClampingScrollPhysics(),
              controller: _pageController,
              itemBuilder: ((context, index) {
                String id = snapshot.data![index].id.toString();
                return Dismissible(
                  key: ValueKey(id),
                  direction: DismissDirection.up,
                  background: Container(
                    color: Colors.redAccent,
                    margin: const EdgeInsets.only(bottom: 0,right: 10),
                    
                  ),
                  onDismissed: (direction){
                    dbHelper!.delete(id); 
                    showSnackbar("Quote Unfavorited!");    
                    setState(() {
                      allFavorites.then((quote){
                        quote.removeAt(index);
                        return quote;

                      });
                    });
                        
                  },
                  child: Center(
                    child: Container(
                      margin: const EdgeInsets.only(right: 30),
                      height: MediaQuery.of(context).size.height * 0.7,
                      width: MediaQuery.of(context).size.width * 0.9,
                      decoration: BoxDecoration(
                        color: _randomColor.randomColor(     
                          colorSaturation: ColorSaturation.lowSaturation,
                          colorBrightness: ColorBrightness.veryLight
                        ),
                        borderRadius: BorderRadius.circular(30),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 3,
                            spreadRadius: 3
                          ),
                        ]
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 40,horizontal: 20),
                        child: Column(
                          children: [
                            Image.asset('assets/quote2.png',
                              height: 40,),
                            const SizedBox(height: 15,),
                            Text(snapshot.data![index].content,
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 30,
                                fontStyle: FontStyle.italic,
                                fontWeight: FontWeight.w500
                              ),
                            ),
                            const SizedBox(height: 20,),
                            Text("by ${snapshot.data![index].author}",
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 23,
                                fontWeight: FontWeight.w400
                              ),)
                          ],
                        ),
                      ),
                    ),
                  )
                );
              })
            );
          }
        }
      )
    );
  }
}