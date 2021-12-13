import 'package:final_quizmaker/widgets/widget.dart';
import 'package:flutter/material.dart';

class Results extends StatefulWidget {
  final int total, correct, incorrect, notattempted;
  Results({required this.incorrect, required this.total, required this.correct, required this.notattempted});

  @override
  _ResultsState createState() => _ResultsState();
}

class _ResultsState extends State<Results> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: AppLogo(),
        //  iconTheme: IconThemeData(color: Colors.black),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        brightness: Brightness.light,
        elevation: 0.0,
      ),
      body: Container(
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
            Text("${widget.correct}/ ${widget.total}", style: TextStyle(fontSize: 30),),
              SizedBox(height: 5,),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 24),
                child: Text(
                  
                    "Correct - ${widget.correct} \n   Incorrect - ${widget.incorrect}",
               style: TextStyle(fontSize: 20), textAlign: TextAlign.center,),

              ),
              SizedBox(height: 24,),
              GestureDetector(
                onTap: (){
                  Navigator.pop(context);
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(30)
                  ),
                  child: Text("Go to home", style: TextStyle(color: Colors.white, fontSize: 19),),
                ),
              )
          ],),
        ),
      ),
    );
  }
}
