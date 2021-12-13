

import 'package:final_quizmaker/pages/login.dart';
import 'package:final_quizmaker/pages/sign_up.dart';
import 'package:final_quizmaker/widgets/widget.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: AppLogo(),
         iconTheme: IconThemeData(color: Colors.black),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        brightness: Brightness.light,
        elevation: 0.0,
      ),
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).copyWith().size.height ,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(100.0),
              child: Image(
                image: AssetImage(
                  'assets/images/welcome.png',
                ),
                fit: BoxFit.fitHeight,
              ),
            ),
          ),
        
          Padding(
            padding: EdgeInsets.fromLTRB(0, 540, 0, 0),
            child: Row(
            
              children: [
                SizedBox(
                  width: 50,
                ),
                SizedBox(
                  height: 50,
                  width: 120,
                  child: RaisedButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    onPressed: () {
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) => Login()));
                    },
                    child: Text(
                      'Login',
                      style: TextStyle(color: Colors.white, fontSize: 15),
                    ),
                    color: Colors.blueGrey,
                  ),
                ),
                SizedBox(
                  width: 30,
                ),
                SizedBox(
                  height: 50,
                  width: 120,
                  child: RaisedButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    onPressed: () {
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) => SignUp()));
                    },
                    child: Text(
                      'Register',
                      style: TextStyle(color: Colors.white, fontSize: 15),
                    ),
                    color: Colors.blueGrey,
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
