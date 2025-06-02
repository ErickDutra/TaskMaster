import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:task_master/components/card/day_tasks_card.dart';
import 'package:task_master/model/task.dart';

class ListTasksPage extends StatefulWidget {
  const ListTasksPage({Key? key}) : super(key: key);

  @override
  _ListTasksPageState createState() => _ListTasksPageState();
}

class _ListTasksPageState extends State<ListTasksPage> {
  List<String> nomesMeses = [];

  Future<List<Task>> carregarTarefas() async {
    final String resposta = await rootBundle.loadString('assets/tasks.json');
    final List<dynamic> dados = json.decode(resposta);
    return dados.map((item) {
      return Task(
        title: item['title'],
        priority: TaskPriority.values.firstWhere(
          (e) => e.name == item['priority'],
          orElse: () => TaskPriority.medium,
        ),
        repeatedMode: RepatedMode.values.firstWhere(
          (e) => e.name == item['repeatedMode'],
          orElse: () => RepatedMode.focusTotal,
        ),
        dateTask:
            item['dateTask'] != null ? DateTime.parse(item['dateTask']) : null,
        notification: item['notification'] ?? false,
        completed: item['completed'] ?? false,
        hoursNotify:
            item['hoursNotify'] != null
                ? DateTime.parse(item['hoursNotify'])
                : null,
      );
    }).toList();
  }

  Future<void> carregarNomesMeses() async {
    final String resposta = await rootBundle.loadString('assets/meses.json');
    final dados = json.decode(resposta);
    setState(() {
      nomesMeses = (dados['meses'] as List).map((e) => e.toString()).toList();
    });
  }

  @override
  void initState() {
    super.initState();
    carregarNomesMeses();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 48, 48, 48),
      body: FutureBuilder<List<Task>>(
        future: carregarTarefas(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Text(
                'Nenhuma tarefa encontrada',
                style: TextStyle(color: Colors.white),
              ),
            );
          }

          // Agrupa as tarefas por data
          final Map<String, List<Task>> tarefasPorData = {};
          for (var task in snapshot.data!) {
            if (task.dateTask != null) {
              final dataFormatada =
                  '${task.dateTask!.day.toString().padLeft(2, '0')} '
                  '${_nomeMes(task.dateTask!.month)} '
                  '${task.dateTask!.year}';
              tarefasPorData.putIfAbsent(dataFormatada, () => []).add(task);
            }
          }

          return ListView(
            children:
                tarefasPorData.entries.map((entry) {
                  return DayTasksCard(date: entry.key, tasks: entry.value);
                }).toList(),
          );
        },
      ),
    );
  }

  String _nomeMes(int mes) {
    if (nomesMeses.isNotEmpty && mes > 0 && mes <= nomesMeses.length) {
      return nomesMeses[mes - 1];
    }
    return '';
  }
}
