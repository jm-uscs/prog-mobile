import 'package:flutter/material.dart';

class Tela1Screen extends StatelessWidget {
  const Tela1Screen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Projeto 2508')),
      body: Center(
        child: Padding(
          padding: const EdgeInsetsGeometry.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [const Text('Tela01'), const SizedBox(height: 20)],
          ),
        ),
      ),
    );
  }
}
