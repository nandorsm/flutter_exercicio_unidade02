import 'package:flutter/material.dart';
import 'package:thiago_exercicio_unidade02/views/main_screen.dart';
import 'package:thiago_exercicio_unidade02/database/database.dart';
import 'package:thiago_exercicio_unidade02/views/main_screenStateless.dart';
import 'model/tarefa.dart';

void main() {
  runApp(const MyApp());
  findAll().then((tarefas) => print(tarefas));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: //MainScreen(),
        MainScreenStateless(),
    );
  }
}