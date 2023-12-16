import 'package:flutter/material.dart';

class QuotesTile extends StatelessWidget {
  const QuotesTile({super.key,required this.author,required this.content,required this.nextScreen});

  final String content;
  final String author;
  final Function() nextScreen;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        nextScreen();
      },
      borderRadius: BorderRadius.circular(40),
      child: Container(
        margin: const EdgeInsets.only(top: 10,bottom: 14,left: 10,right: 10),
        height: MediaQuery.of(context).size.height * 0.5,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [
              Color.fromARGB(255, 244, 106, 96),
              Color.fromARGB(255, 218, 66, 55),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter
          ),
          borderRadius: BorderRadius.circular(40),
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              spreadRadius:4,
              blurRadius: 6,
            )
          ]  
        ),
        child: Padding(
          padding:const EdgeInsets.fromLTRB(20, 20, 15, 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset("assets/quote.png",
                height: 50,),
              const SizedBox(height: 10,),
              Text(content,
                style: Theme.of(context).textTheme.bodyLarge,),
      
              const Spacer(),
              Text(author,
                style: Theme.of(context).textTheme.bodySmall,)
            ],
          ),
        ),
      ),
    );
  }
}