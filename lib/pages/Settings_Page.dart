import 'package:chatwithme/themes/Theme_Provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatelessWidget{
  const SettingsPage ({super.key});

  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        title: Text('Settings' ),
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.grey,
        elevation: 0,
        centerTitle: true,
      ),
      body: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondary,
          borderRadius: BorderRadius.circular(12),
        ),
        margin: EdgeInsets.all(25),
        padding: EdgeInsets.all(15),
        child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,

        children: [
          //dark mode
          Text("Dark Mode"),

          //switch toggle
          CupertinoSwitch(
              value: Provider.of<ThemeProvider>(context,listen:false).isDarkMode,
              onChanged: (value) => Provider.of<ThemeProvider>(context,listen:false).toggleTheme(),
          )
        ],
      ),
      ),
    );
  }
}
