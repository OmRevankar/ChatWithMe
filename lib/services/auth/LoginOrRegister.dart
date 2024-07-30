import 'package:chatwithme/pages/login_page.dart';
import 'package:chatwithme/pages/register_page.dart';
import 'package:flutter/material.dart';

class LoginOrregister extends StatefulWidget{
  LoginOrregister ({super.key});

  @override
  State<LoginOrregister> createState() => _LoginOrRegisterState();
}

class _LoginOrRegisterState extends State<LoginOrregister>{

  bool showLoginPage = true;

  void togglePages(){
    setState(() {
      showLoginPage = !showLoginPage;
    });
  }

  @override
  Widget build(BuildContext context) {

    if(showLoginPage)
      {
        return LoginPage(
          onTap: togglePages,
        );
      }
    else
      {
        return RegisterPage(
          onTap: togglePages,
        );
      }
  }
}
