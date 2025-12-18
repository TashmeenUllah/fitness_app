import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Fitness App"),
      ),
      body: const Center(
        child: Text(
          "Welcome to Fitness App",
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
