import 'package:flutter/material.dart';
import 'package:minum_music_app/pages/setting_page.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.surface,
      child: Column(
        children: [
          //logo
          DrawerHeader(
            child: Center(
            
              child: CircleAvatar(
              backgroundImage: NetworkImage("https://www.freepik.com/pikaso/ai-image-generator?prompt=A%20young%20Asian%20woman%20in%20a%20long%20white%20dress%20in%20motion%20and%20an%20astronaut%20helmet,%20standing%20in%20a%20desert%20landscape%20with%20red%20sand%20dunes%20in%20the%20background#from_element=home_inspired"),
                 
            ),
            ),
          ),

          //List Tile 
          //home tile
          Padding(
            padding: const EdgeInsets.only(left: 25.0,top: 25),
            child: ListTile(
              title: Text(" H O M E "),
              leading: Icon(Icons.home) ,
              onTap: () => Navigator.pop(context),
            ),
          ),

          // settings tile
          Padding(
            padding: const EdgeInsets.only(left: 25.0,top: 25),
            child: ListTile(
              title: Text("S E T T I N G S"),
              leading: Icon(Icons.settings) ,
              onTap: () {
                // pop drawer
                Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(builder: (context)=>SettingsPage(),));
              },
            ),
          ),


        ],
      ),
    );
  }
}
