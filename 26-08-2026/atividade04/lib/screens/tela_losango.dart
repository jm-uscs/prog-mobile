import 'package:flutter/material.dart';

class TelaLosangoScreen extends StatelessWidget{
  const TelaLosangoScreen ({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tela Circulo'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsetsGeometry.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Tela Circulo'),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}