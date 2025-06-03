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
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Card(
                margin: const EdgeInsets.all(8.0),
                color: const Color.fromARGB(255, 48, 48, 48),
                child: Center(child: Column(
                 children: [
                   Text('Metrica',
                     style: const TextStyle(
                       color: Colors.blue,
                       fontSize: 20,
                       fontWeight: FontWeight.bold,
                       decoration: TextDecoration.underline,                    
                     ),
                   ),
                   Column(
                     children: [
                       Row(
                         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                         children: [ 
                          Container(
                            height: 40,
                             width: 30,
                    
                            decoration: BoxDecoration(
                               color: Colors.blue,
                               borderRadius: BorderRadius.circular(10),
                             ),
                             padding: const EdgeInsets.all(10.0),
                           child: Center(
                             child: Text('03',
                                 style: TextStyle(
                                   color: Colors.white,
                                   fontSize: 16,
                                 ),
                               ),
                           ),
                         ),
                           Text('Tarefas Completas',
                             style: TextStyle(
                               color: Colors.white,
                               fontSize: 16,
                             ),
                           ),
                          
                         ],
                       ),
                        const SizedBox(height: 8),
                   Row(
                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                     children:  [ Container(
                       height: 40,
                        width: 30,
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          padding: const EdgeInsets.all(8.0),
                       child: Center(
                         child: Text('01',
                             style: TextStyle(
                               color: Colors.white,
                               fontSize: 16,
                             ),
                           ),
                       ),
                     ),
                       Text('Tarefas Perdidas   ',
                         style: TextStyle(
                           color: Colors.white,
                           fontSize: 16,
                         ),
                       ),
                      
                     ],
                   ),
                     ],
                   ),
                
                   ElevatedButton(onPressed:(){}, 
                   style: ElevatedButton.styleFrom(
                     backgroundColor: Colors.blue,
                     shape: RoundedRectangleBorder(
                       borderRadius: BorderRadius.circular(20),
                     ),
                   ),
                   child:Text('Zerar Metrica',
                     style: const TextStyle(
                       color: Colors.black,
                       fontSize: 16,
                    
                     ),
                   )),
                 ],
                ),),
              
              ),
            ],
          ),
 Padding(
          padding: const EdgeInsets.all(16.0),
          child: ElevatedButton(
            onPressed: () {
              Navigator.pushReplacementNamed(context, '/login');
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              minimumSize: const Size.fromHeight(48),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: const Text(
              'Sair',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
              ),
            ),
          ),
        ),
    
        ],
      ),
    );
  }
}