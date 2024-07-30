import 'package:chatwithme/services/auth/auth_service.dart';
import 'package:chatwithme/components/My_Button.dart';
import 'package:chatwithme/components/My_TextField.dart';
import 'package:flutter/material.dart';
import 'package:chatwithme/pages/Chat_Page.dart';

class LoginPage extends StatelessWidget
{
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  void Function()? onTap;

  LoginPage ({super.key , required this.onTap});



  void login(BuildContext context) async{
    //get auth service
    final authService = AuthService();

    //try login
    try {
      await authService.signInWithEmailPassword(
          _emailController.text,
          _passwordController.text
      );
    }
    //catch errors
    catch(e){
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
            title:Text(e.toString()),
        ),

      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,

      body: Center(
       child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          //logo
          Icon(
              Icons.message,
              size: 60,
              color: Theme.of(context).colorScheme.primary,
          ),
          const SizedBox(height: 50),

          //welcome back message
          Text('LOGIN HERE',
            style: TextStyle(
              color: Colors.grey,
              fontSize: 20,
            ),
          ),
          const SizedBox(height:50),
          //email text
          MyTextField(
            hintText: 'ENTER EMAIL',
            obsecureText: false,
            controller: _emailController,
            focusNode:FocusNode(),
          ),
          const SizedBox(height: 20),

          //password
          MyTextField(
              hintText: 'PASSWORD',
              obsecureText: true,
              controller: _passwordController,
            focusNode:FocusNode(),
          ),
          const SizedBox(height: 25,),
          //login
          MyButton(
              text: 'LOGIN',
              onTap: ()=> login(context),
          ),

          const SizedBox(height: 20,),
          //register
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                  "Don't have an account ? ",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              GestureDetector(
                onTap: onTap,
                child: Text(
                  'Register Now',
                  style:TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.primary,
                  )
                ),
              ),

              const SizedBox(height: 20,),
            ],
          )
        ],
      ),
    ),
    );
  }
}
