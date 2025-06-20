import 'package:flutter/material.dart';
import 'package:task_master/pages/calender_page.dart';
import 'package:task_master/pages/draw_custom.dart';
import 'package:task_master/pages/list_tasks.dart';
import 'package:task_master/pages/login_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _logado = false;

  void _login() {
    setState(() {
      _logado = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TaskMaster',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.black,
          primary: Colors.white,
          secondary: Colors.grey,
        ),
      ),
      home: _logado
          ? MyHomePage(title: 'TaskMaster')
          : LoginPage(onLogin: _login),
      initialRoute: _logado ? '/home' : '/login',
      routes: {
    '/login': (context) => LoginPage(onLogin: _login),
    '/home': (context) => MyHomePage(title: 'TaskMaster'),
    '/calendar': (context) => CalendarPageStateless(),
    '/tasks': (context) => ListTasksPage(),
  },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;

  static final List<Widget> _pages = <Widget>[
    ListTasksPage(),
    Center(child: Text('Pesquisa')),
    CalendarPageStateless(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      drawer: CustomDrawer(),
      bottomNavigationBar: BottomAppBar(
        color: Colors.grey,

        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            IconButton(
              style: IconButton.styleFrom(
                iconSize: 45,
                foregroundColor: Colors.black,
              ),
              icon: const Icon(Icons.home),
              onPressed: () => _onItemTapped(0),
            ),
            if (_selectedIndex ==0)
              IconButton(
                style: IconButton.styleFrom(
                  iconSize: 45,
                  backgroundColor: Colors.black,
                  foregroundColor: Colors.green,
                  padding: const EdgeInsets.all(2),
                ),
                icon: const Icon(Icons.check),
                onPressed: () => _onItemTapped(1),
              ),
            IconButton(
              style: IconButton.styleFrom(
                iconSize: 45,
                foregroundColor: Colors.black,
              ),
              icon: const Icon(Icons.calendar_today_sharp),
              onPressed: () => _onItemTapped(2),
            ),
          ],
        ),
      ),
    );
  }
}
