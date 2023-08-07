import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: MainPage());
  }
}

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          height: 50,
          width: 50,
          color: Colors.blue,
          child: InkWell(
            onTap: () async {
              final String data = await  rootBundle.loadString("assets/data/data.json");
              print(data);
            },
            child: const Text('Click Me'),
          ),
        ),
      ),
    );
  }
}
