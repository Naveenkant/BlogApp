import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_quizmaker/quiz/create_quiz.dart';
import 'package:final_quizmaker/quiz/play_quiz.dart';
import 'package:final_quizmaker/services/database.dart';
import 'package:final_quizmaker/widgets/widget.dart';
import 'package:flutter/material.dart';

class See extends StatefulWidget {
  const See({Key? key}) : super(key: key);

  @override
  _SeeState createState() => _SeeState();
}

class _SeeState extends State<See> {
  late Stream<QuerySnapshot> quizStream;
  DatabaseService databaseService = new DatabaseService(uid: '');
  @override
  void initState() {
    databaseService.getQuizData().then((value) {
      quizStream = value;
      setState(() {});
    });
    super.initState();
  }

  Widget quizList() {
    return Container(
        child: Column(
      children: [
        StreamBuilder<QuerySnapshot>(
            stream: quizStream,
            builder: (context, snapshot) {
              return snapshot.data == null
                  ? Container()
                  : Expanded(
                      child: SizedBox(
                        child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: snapshot.data!.documents.length,
                            itemBuilder: (context, index) {
                              return QuizTile(
                                quizId: snapshot
                                    .data!.documents[index].data["quizId"],

                                desc: snapshot
                                    .data!.documents[index].data["quizDesc"],
                                // id: snapshot.data!.documents[index].data['id'],
                                imageUrl: snapshot
                                    .data!.documents[index].data['quizImagUrl'],
                                // noOfQuestions: snapshot.data!.documents.length,
                                title: snapshot
                                    .data!.documents[index].data['quizTitle'],
                              );
                            }),
                      ),
                    );
            })
      ],
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     appBar: AppBar(
        title: AppLogo(),
        centerTitle: true,
         iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.transparent,
        brightness: Brightness.light,
        elevation: 0.0,
      ),
      body: quizList(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => CreateQuiz()));
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}

class QuizTile extends StatelessWidget {
  final String imageUrl, title, desc, quizId;

  const QuizTile(
      {Key? key,
      required this.imageUrl,
      required this.title,
      required this.desc,
      required this.quizId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => QuizPlay(quizId)));
      },
      child: Container(
        margin: EdgeInsets.fromLTRB(0, 5, 0, 8),
        padding: EdgeInsets.symmetric(horizontal: 15),
        height: 150,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Stack(
            children: [
              Image.network(
                imageUrl,
                fit: BoxFit.cover,
                width: MediaQuery.of(context).size.width,
              ),
              Container(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                            fontWeight: FontWeight.w500),
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      Text(
                        desc,
                        style: TextStyle(
                            fontSize: 13,
                            color: Colors.white,
                            fontWeight: FontWeight.w500),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
