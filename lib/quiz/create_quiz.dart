import 'package:final_quizmaker/quiz/addQuestion.dart';
import 'package:final_quizmaker/services/database.dart';
import 'package:final_quizmaker/widgets/widget.dart';
import 'package:flutter/material.dart';
import 'package:random_string/random_string.dart';

class CreateQuiz extends StatefulWidget {
  CreateQuiz({Key? key}) : super(key: key);

  @override
  _CreateQuizState createState() => _CreateQuizState();
}

class _CreateQuizState extends State<CreateQuiz> {
  bool isLoading = false;
  late String quizImageUrl, quizTitle, quizDescription, quizId;
  DatabaseService databaseService = new DatabaseService(uid: '');
  final _formKey = GlobalKey<FormState>();
  createQuiz() {
    quizId = randomAlphaNumeric(16);
    if (_formKey.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });
      Map<String, String> quizData = {
        "quizId": quizId,
        "quizImagUrl": quizImageUrl,
        "quizTitle": quizTitle,
        "quizDesc": quizDescription
      };
      databaseService.addQuizData(quizData, quizId).then((value) {
        setState(() {
          isLoading = false;
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => AddQuestion(quizId)));
        });
      });
    }
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
      body: isLoading
          ? Container(child: Center(child: CircularProgressIndicator()))
          : Form(
              key: _formKey,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  children: [
                    TextFormField(
                      onChanged: (val) {
                        quizImageUrl = val;
                      },
                      validator: (val) =>
                          val!.isEmpty ? "Enter Blog Image Url" : null,
                      decoration: InputDecoration(
                          hintText: "Blog Image Url (Optional)"),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    TextFormField(
                      onChanged: (val) {
                        quizTitle = val;
                      },
                      validator: (val) =>
                          val!.isEmpty ? "Enter Blog Title" : null,
                      decoration: InputDecoration(hintText: "Blog Title"),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    TextFormField(
                      onChanged: (val) {
                        quizDescription = val;
                      },
                      validator: (val) =>
                          val!.isEmpty ? "Enter BLog Description" : null,
                      decoration: InputDecoration(hintText: "Blog Description"),
                    ),
                    Spacer(),
                    GestureDetector(
                      onTap: () {
                        createQuiz();
                      },
                      child: Container(
                        alignment: Alignment.center,
                        width: MediaQuery.of(context).size.width,
                        padding:
                            EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                        decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(30)),
                        child: Text(
                          "Create Blog",
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 60,
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
