import 'package:final_quizmaker/pages/see.dart';
import 'package:final_quizmaker/services/auth.dart';
import 'package:final_quizmaker/widgets/widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

class Login extends StatefulWidget {
  Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}
class _LoginState extends State<Login> {
  bool tapped = false;
  bool isLoading = false;
  late String email, password;
  AuthService authService = new AuthService();
  final _formKey = GlobalKey<FormState>();
  moveToLogin() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        tapped = true;
        isLoading = true;
      });
      authService.signInEmailAndPass(email, password).then((value) async {
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
                            onChanged: (val) {
                              email = val;
                            },
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'email cannot be empty';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                                hintText: 'Enter the Email',
                                labelText: 'Email'),
                          ),
                          TextFormField(
                            onChanged: (val) {
                              password = val;
                            },
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Password cannot be empty';
                              } else if (value.length < 6) {
                                return 'Password length should be atleast 6';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                                hintText: 'Enter the Email',
                                labelText: 'Password'),
                            obscureText: true,
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: 30),
                    InkWell(
                      onTap: moveToLogin,
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
                                'Login',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 15),
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
