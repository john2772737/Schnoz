import 'package:flutter/material.dart';
// Make sure this file name matches exactly what is in your folder
import 'Screen/live_View.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Schnoz Medical Device',
      debugShowCheckedModeBanner: false, // Removes the "Debug" banner
      theme: ThemeData(
        // FIXED: Added 'ColorScheme' before .fromSeed
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      // We wrap the container in a Scaffold so it looks like a proper page
      home: Scaffold(
        backgroundColor: Colors.blueGrey[900], // Dark medical background
        appBar: AppBar(
          title: const Text("System Check"),
          backgroundColor: Colors.blueGrey[800],
          foregroundColor: Colors.white,
        ),
        body: Center(

        ),
      ),
    );
  }
}