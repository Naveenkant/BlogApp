import 'package:final_quizmaker/pages/home_page.dart';
import 'package:final_quizmaker/pages/see.dart';
import 'package:final_quizmaker/services/auth.dart';
import 'package:final_quizmaker/widgets/widget.dart';
import 'package:flutter/material.dart';

class SignUp extends StatefulWidget {
  SignUp({Key? key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  bool tapped = false;
  bool isLoading = false;
  late String email, password;
  AuthService authService = new AuthService();
  final _formKey = GlobalKey<FormState>();
  moveToRegister() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        tapped = true;
        isLoading = true;
      });
      authService.signUpwithEmailAndPass(email, password).then((value) async {
        if (value != null) {
          setState(() {
            isLoading = false;
          });
          await Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => See()));
        }
      });
      await Future.delayed(Duration(seconds: 1));

      setState(() {
        tapped = false;
      });
    }
  }

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
      body: isLoading
          ? Container(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            )
          : Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      height: 300,
                      child: Padding(
                        padding: EdgeInsets.all(5),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(30.0),
                          child: Image(
                            image: AssetImage(
                              'assets/images/register.png',
                            ),
                            fit: BoxFit.fitHeight,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      child: Column(
                        children: [
                          TextFormField(
                            
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Enter the Name';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              hintText: 'Enter your Name',
                              labelText: 'Name',
                              icon: Icon(Icons.person),
                            ),
                          ),
                          TextFormField(
                            onChanged: (val) {
                              email = val;
                            },
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Enter the valid email';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              hintText: 'Enter your Email',
                              labelText: 'Email',
                              icon: Icon(Icons.email),
                            ),
                          ),
                          TextFormField(
                            onChanged: (val) {
                              password = val;
                            },
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Enter the Password';
                              } else if (value.length < 6) {
                                return 'Password length atleast should be 6';
                              }
                              return null;
                            },
                            obscureText: true,
                            decoration: InputDecoration(
                              hintText: 'Enter your Password',
                              labelText: 'Password',
                              icon: Icon(Icons.password_outlined),
                            ),
                          ),
                          SizedBox(height: 30),
                          InkWell(
                            onTap: moveToRegister,
                            child: AnimatedContainer(
                              duration: Duration(seconds: 1),
                              height: 50,
                              alignment: Alignment.center,
                              width: tapped ? 50 : 150,
                              decoration: BoxDecoration(
                                  color: Colors.blue,
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(tapped ? 50 : 10))),
                              child: tapped
                                  ? Icon(
                                      Icons.done,
                                      color: Colors.white,
                                    )
                                  : Text(
                                      'Register',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 15),
                                    ),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
    );
  }
}
