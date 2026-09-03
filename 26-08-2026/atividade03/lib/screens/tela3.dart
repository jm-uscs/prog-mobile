import 'package:flutter/material.dart';

class Tela3Screen extends StatelessWidget {
  const Tela3Screen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tela 03')),
      body: Center(
        child: Padding(
          padding: const EdgeInsetsGeometry.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Tela 03',
                style: TextStyle(
                  fontSize: 32.0,
                  fontWeight: FontWeight.w500,
                  color: Colors.deepPurple,
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
