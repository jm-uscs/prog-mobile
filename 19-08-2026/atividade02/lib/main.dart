import 'package:flutter/material.dart';

void main() {
  runApp(const MinhaCalculadoraApp());
}

class MinhaCalculadoraApp extends StatelessWidget {
  const MinhaCalculadoraApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculadora',
      debugShowCheckedModeBanner: false,
      home: const TelaCalculadora(),
    );
  }
}

class TelaCalculadora extends StatefulWidget {
  const TelaCalculadora({super.key});

  @override
  State<TelaCalculadora> createState() => _TelaCalculadoraState();
}

class _TelaCalculadoraState extends State<TelaCalculadora> {
  final TextEditingController _controladorNum1 = TextEditingController();
  final TextEditingController _controladorNum2 = TextEditingController();
  String _resultado = '';

  double? _lerNumero(String texto) {
    return double.tryParse(texto.replaceAll(',', '.'));
  }

  void _somar() {
    final num1 = _lerNumero(_controladorNum1.text);
    final num2 = _lerNumero(_controladorNum2.text);
    setState(() {
      if (num1 == null || num2 == null) {
        _resultado = 'Digite dois números válidos';
      } else {
        _resultado = 'Resultado: ${num1 + num2}';
      }
    });
  }

  void _subtrair() {
    final num1 = _lerNumero(_controladorNum1.text);
    final num2 = _lerNumero(_controladorNum2.text);
    setState(() {
      if (num1 == null || num2 == null) {
        _resultado = 'Digite dois números válidos';
      } else {
        _resultado = 'Resultado: ${num1 - num2}';
      }
    });
  }

  void _multiplicar() {
    final num1 = _lerNumero(_controladorNum1.text);
    final num2 = _lerNumero(_controladorNum2.text);
    setState(() {
      if (num1 == null || num2 == null) {
        _resultado = 'Digite dois números válidos';
      } else {
        _resultado = 'Resultado: ${num1 * num2}';
      }
    });
  }

  void _dividir() {
    final num1 = _lerNumero(_controladorNum1.text);
    final num2 = _lerNumero(_controladorNum2.text);
    setState(() {
      if (num1 == null || num2 == null) {
        _resultado = 'Digite dois números válidos';
      } else if (num2 == 0) {
        _resultado = 'Não é possível dividir por zero';
      } else {
        _resultado = 'Resultado: ${num1 / num2}';
      }
    });
  }

  @override
  void dispose() {
    _controladorNum1.dispose();
    _controladorNum2.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Calculadora')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _controladorNum1,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Primeiro número',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _controladorNum2,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Segundo número',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(onPressed: _somar, child: const Text('+')),
                ElevatedButton(onPressed: _subtrair, child: const Text('-')),
                ElevatedButton(onPressed: _multiplicar, child: const Text('×')),
                ElevatedButton(onPressed: _dividir, child: const Text('÷')),
              ],
            ),
            const SizedBox(height: 24),
            Text(
              _resultado,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}