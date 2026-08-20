import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'model/Aluno.dart';

void main() {
  runApp(const Aula2App());
}

class Aula2App extends StatelessWidget {
  const Aula2App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Aula 2 - Form + Layout',
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.indigo
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _formKey = GLobalKey<FormState>();

  final _nomeCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _idadeCtrl = TextEditingController();

  String? _cursoSelecionado;
  bool _receberNovidades = true;

  final List<String> _cursos = const [
    'Analise e Desenvolvimento de Sistemas',
    'Engenharia de Software',
    'Ciência da Computação',
    'Sistemas de Informação',
    'Jogos Digitais',
    'Outro'
  ];

  @override
  void dispose() {
    _nomeCtrl.dispose();
    _emailCtrl.dispose();
    _idadeCtrl.dispose();
    super.dispose();
  }

  void _limpar() {
    _nomeCtrl.clear();
    _emailCtrl.clear();
    _idadeCtrl.clear();
    setState(() {
      _cursoSelecionado = null;
      _receberNovidades = true;
    });
  }

  String? _validarEmail(String? value) {
    final v = value?.trim() ?? '';
    if (v.isEmpty) {
      return 'Informe o e-mail';
    }
    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+$').hasMatch(v)) {
      return 'E-mail inválido';
    }
    return null;
  }

  void _salvar() {
    final formOk = _formKey.currentState?.validate() ?? false;
    if (!formOk) return;

    final idade = int.tryParse(_idadeCtrl.text.trim()) ?? 0;

    final aluno = Aluno(
      nome: _nomeCtrl.text.trim(),
      email: _emailCtrl.text.trim(),
      idade: idade,
      curso: _cursoSelecionado ?? '',
      receberNovidades: _receberNovidades,
    );

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Cadastro validado!'),
      ),
    );

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ResumoPage(aluno: aluno),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Aula 2 - Formulário e Layout'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              _buildExemploLayout(),
              const SizedBox(height: 16),

              const _SectionHeader(titulo: 'Dados do Aluno'),
              Form
            ]
          )
        )
      )
    );





}

