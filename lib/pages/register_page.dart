import 'package:chatwithme/services/auth/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:chatwithme/components/My_Button.dart';
import 'package:chatwithme/components/My_TextField.dart';
import 'package:chatwithme/pages/Chat_Page.dart';

class RegisterPage extends StatelessWidget{

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmpasswordController = TextEditingController();
  void Function()? onTap;

  RegisterPage({super.key , required this.onTap});

  void register(BuildContext context){
    //get auth service
    final _auth = AuthService();

    //if passwords match -> create user
    if(_confirmpasswordController.text == _passwordController.text){
      try{
        _auth.signUpWithEmailPassword(_emailController.text , _passwordController.text);
      } catch(e){
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title:Text(e.toString()),
          ),

        );
      }
    }
    //if passwords dont match -> tell user to fix
    else{
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
          title:Text("Passwords Don't Match")
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
            const SizedBox(height: 50,),

            //welcome back message
            Text("Let's create an account for you !",
              style: TextStyle(
                color: Colors.grey,
                fontSize: 20,
              ),
            ),
            const SizedBox(height:50),
            //email text
            MyTextField(
              hintText: 'Enter EMAIL',
              obsecureText: false,
              controller: _emailController,
                focusNode:FocusNode(),
            ),
            const SizedBox(height: 20),

            //password
            MyTextField(
              hintText: 'Enter PASSWORD',
              obsecureText: true,
              controller: _passwordController,
              focusNode:FocusNode(),
            ),
            const SizedBox(height: 20,),

            //confirm password
            MyTextField(
              hintText: 'Confirm PASSWORD',
              obsecureText: true,
              controller: _confirmpasswordController,
              focusNode:FocusNode(),
            ),
            const SizedBox(height: 25,),

            //login
            MyButton(
                text: 'REGISTER',
                onTap: () => register(context),
              ),

            const SizedBox(height: 20,),
            //register
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Already have an account ? ",
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                GestureDetector(
                    onTap: onTap,
                    child: Text('Login here',
                    style:TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                )
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
