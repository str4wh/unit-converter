import 'package:flutter/material.dart';
import 'package:my_unit_converter/temperature_converter_screen.dart';

void main() {
  runApp(const MyApp());
}

//This is the main app
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Unit Converter',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
      ),
      debugShowCheckedModeBanner: false,
      home: const MyHomePage(title: 'Unit Converter'),
    );
  }
}

//This is the home page
class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // button to navigate to the temperature converter screen
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const TemperatureConverterScreen(),
                  ),
                );
              },
              child: const Text('Temperature Converter'),
            ),
          ],
        ),
      ),
    );
  }
}








