import 'package:flutter/material.dart';
import 'package:thiago_exercicio_unidade02/model/tarefa.dart';
import '../database/database.dart';

class MainScreenStateless extends StatelessWidget {
  const MainScreenStateless({super.key});

  //final tarefa = TextEditingController();

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Banco de dados"),
      ),
      body: Center(
        child: Container(
                child: FutureBuilder(
                  future: Future.delayed(Duration(seconds: 5)).then((value) => findAll()),
                  builder: (context, snapshot) {
                    if(snapshot.hasData){
                      List<Tarefa> tarefas = snapshot.data as List<Tarefa>;
                      return ListView.builder(
                          itemCount: tarefas.length,
                          itemBuilder: (context,i){
                            return Card(
                              child: Text("${tarefas[i].nome}"),
                            );
                          }
                      );
                    }else if(snapshot.hasError){
                      return Text("Error");
                    }else{
                        return CircularProgressIndicator();
                    }
                  }
                ),
        ),
      ),
    );
  }
  
  
}