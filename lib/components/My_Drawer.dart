import 'package:flutter/material.dart';
import '../pages/Settings_Page.dart';
import 'package:chatwithme/services/auth/auth_service.dart';

class MyDrawer extends StatelessWidget{
  MyDrawer ({super.key});

  void logout(){
    //get auth service
    final _auth = AuthService();
    _auth.signOut();
  }

  @override
  Widget build(BuildContext context){
      return Drawer(
        backgroundColor: Theme.of(context).colorScheme.surface,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                //logo
                DrawerHeader(
                    child: Center(
                      child: Icon(
                        Icons.message,
                        color: Theme.of(context).colorScheme.primary,
                        size: 40,

                      ),
                    )
                ),

                //home list tile
                Padding(
                    padding: const EdgeInsets.only(left:25),
                    child:ListTile(
                      title: Text("HOME"),
                      leading: Icon(Icons.home_sharp , color: Theme.of(context).colorScheme.primary,),
                      onTap: () {
                        //pop the drawer
                        Navigator.pop(context);
                      },
                    )
                ),

                //setting list tile
                Padding(
                    padding: const EdgeInsets.only(left:25 ),
                    child:ListTile(
                      title: Text("SETTINGS"),
                      leading: Icon(Icons.settings , color: Theme.of(context).colorScheme.primary,),
                      onTap: () {
                        //pop the drawer
                        Navigator.pop(context);
                        //navigate to the settings page
                        Navigator.push(context , MaterialPageRoute(builder: (context) => SettingsPage() , ));
                      },
                    )
                ),
              ],
            ),

            //logout list tile
            Padding(
                padding: const EdgeInsets.only(left:25,bottom: 20),
                child:ListTile(
                  title: Text("LOGOUT"),
                  leading: Icon(Icons.logout , color: Theme.of(context).colorScheme.primary,),
                  onTap: logout,
                )
            ),
          ],
        )
      );
  }
}
