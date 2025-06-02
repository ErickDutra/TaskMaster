import 'package:flutter/material.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.grey,
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          const DrawerHeader(
            decoration: BoxDecoration(color: Colors.grey),
            child: Center(
              
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundImage: NetworkImage('https://picsum.photos/id/237/200/300'), 
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Erick Dutra',
                    style: TextStyle(
                      color: Colors.black54,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            )
          ),
          Card(
            margin: const EdgeInsets.all(8.0),
            color: Colors.blue,
            child: Row(
              children: [
                 Center(child: const Text('Metrica', style: TextStyle(color: Colors.white))),
              ],
            ),

          ),
        ],
      ),
    );
  }
}