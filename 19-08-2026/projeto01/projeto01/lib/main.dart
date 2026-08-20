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
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.indigo),
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
  final _formKey = GlobalKey<FormState>();

  final _nomeCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _idadeCtrl = TextEditingController();

  String? _cursoSelecionado;
  bool _receberNovidades = true;

  final List<String> _cursos = const [
    'Analise e Desenvolv. de Sistemas',
    'Engenharia de Software',
    'Ciência da Computação',
    'Sistemas de Informação',
    'Jogos Digitais',
    'Outro',
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
      curso: _cursoSelecionado!,
      receberNovidades: _receberNovidades,
    );

    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text('Cadastro validado!')));

    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => ResumoPage(aluno: aluno)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Aula 2 - Formulário e Layout')),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              _buildExemploLayout(),
              const SizedBox(height: 16),

              const _SectionHeader(titulo: 'Dados do Aluno'),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: _nomeCtrl,
                      decoration: const InputDecoration(
                        labelText: 'Nome',
                        hintText: 'Ex.: Maria Silva',
                        prefixIcon: Icon(Icons.person),
                        border: OutlineInputBorder(),
                      ),
                      textInputAction: TextInputAction.next,
                      validator: (v) {
                        final value = v?.trim() ?? '';
                        if (value.isEmpty) return 'Informe o nome';
                        if (value.length < 3) {
                          return 'Mínimo de 3 caracteres';
                        }
                        return null;
                      },
                      onChanged: (_) => setState(() {}),
                    ),
                    const SizedBox(height: 12),
                    //E-mail
                    TextFormField(
                      controller: _emailCtrl,
                      decoration: const InputDecoration(
                        labelText: 'E-mail',
                        hintText: 'Ex.: maria@examplo.com',
                        prefixIcon: Icon(Icons.email),
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                      validator: _validarEmail,
                      onChanged: (_) => setState(() {}),
                    ),
                    const SizedBox(height: 12),
                    //Idade
                    TextFormField(
                      controller: _idadeCtrl,
                      decoration: const InputDecoration(
                        labelText: 'Idade',
                        hintText: 'Ex.: 20',
                        prefixIcon: Icon(Icons.numbers),
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      textInputAction: TextInputAction.next,
                      validator: (v) {
                        final value = v?.trim() ?? '';
                        if (value.isEmpty) return 'Informe a idade';
                        final n = int.tryParse(value);
                        if (n == null) return 'Apenas números';
                        if (n < 0 || n > 120) return 'Idade fora do intervalo';
                        return null;
                      },
                      onChanged: (_) => setState(() {}),
                    ),
                    const SizedBox(height: 12),
                    //Curso
                    DropdownButtonFormField<String>(
                      value: _cursoSelecionado,
                      items: _cursos
                          .map(
                            (c) => DropdownMenuItem(value: c, child: Text(c)),
                          )
                          .toList(),
                      decoration: const InputDecoration(
                        labelText: 'Curso',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.school),
                      ),
                      validator: (v) => v == null ? 'Selecione o curso' : null,
                      onChanged: (v) => setState(() {
                        _cursoSelecionado = v;
                      }),
                    ),
                    const SizedBox(height: 4),
                    //SWITCH
                    SwitchListTile(
                      title: const Text(
                        'Receber novidades por e-mail? (opcional)',
                      ),
                      value: _receberNovidades,
                      onChanged: (v) => setState(() {
                        _receberNovidades = v;
                      }),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 12),

              const _SectionHeader(titulo: 'Prévia (atualizada em tempo real)'),
              _buildCardPrevia(),

              const SizedBox(height: 12),

              Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: _limpar,
                      icon: const Icon(Icons.refresh),
                      label: const Text('Limpar'),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: _salvar,
                      icon: const Icon(Icons.save),
                      label: const Text('Salvar e ver resumo'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildExemploLayout() {
    
  }




}
