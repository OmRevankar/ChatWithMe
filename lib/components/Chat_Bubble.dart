import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:chatwithme/themes/Theme_Provider.dart';

class ChatBubble extends StatelessWidget{
  final String message;
  final bool isCurrentUser;


  const ChatBubble({super.key , required this.message , required this.isCurrentUser});

  @override
  Widget build(BuildContext context) {

    bool isDarkMode = Provider.of<ThemeProvider>(context,listen:false).isDarkMode;

    return Container(
      decoration: BoxDecoration(
        color: isCurrentUser ? (isDarkMode ? Colors.green.shade600 : Colors.green.shade500 ) : (isDarkMode ? Colors.grey.shade800 : Colors.grey.shade200 ),
        borderRadius: BorderRadius.circular(12),

      ),
      margin: EdgeInsets.symmetric(vertical: 5,horizontal: 20),
      padding: EdgeInsets.all(15),
      child: Text(
          message,
          style: TextStyle(
            color: isDarkMode ? Colors.white : Colors.grey.shade900,
          ),
      ),

    );
  }

}
