import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:task_master/model/task.dart';

class EditTaskDialog extends StatefulWidget {
  final String? dateTask;

  const EditTaskDialog({super.key, this.dateTask});

  @override
  State<EditTaskDialog> createState() => _EditTaskDialogState();
}
class _EditTaskDialogState extends State<EditTaskDialog> {
  final TextEditingController controller = TextEditingController();
  bool notification = false;
  TaskPriority _selectedPriority = TaskPriority.medium;
  RepatedMode _selectedRepatedMode = RepatedMode.focusTotal;

  List<Task> _tarefas = [];
  Task? _tarefaSelecionada;

  @override
  void initState() {
    super.initState();
    carregarTarefas().then((tarefas) {
      setState(() {
        _tarefas = tarefas;
        if (_tarefas.isNotEmpty) {
          _tarefaSelecionada = _tarefas.first;
          _preencherCampos(_tarefaSelecionada!);
        }
      });
    });
  }

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
      dateTask: item['dateTask'] != null ? DateTime.parse(item['dateTask']) : null,
      notification: item['notification'] ?? false,
      completed: item['completed'] ?? false,
      hoursNotify: item['hoursNotify'] != null ? DateTime.parse(item['hoursNotify']) : null,
    );
  }).toList();
}

  void _preencherCampos(Task tarefa) {
    controller.text = tarefa.title;
    _selectedPriority = tarefa.priority;
    _selectedRepatedMode = tarefa.repeatedMode;
    notification = tarefa.notification;
  }

  @override
  Widget build(BuildContext context) {
    String dataHoje = widget.dateTask ?? 'Data não selecionada';
    String horaAtual =
        '${DateTime.now().hour.toString().padLeft(2, '0')}:${DateTime.now().minute.toString().padLeft(2, '0')}';

    return AlertDialog(
      backgroundColor: Colors.grey,
      title: Container(
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
        decoration: BoxDecoration(
          color: Colors.green,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(
          dataHoje,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 25,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      content: SizedBox(
        width: 320,
        height: 350,
        child: ListView(
          shrinkWrap: true,
          children: [
  
            DropdownButton<Task>(
              value: _tarefaSelecionada,
              isExpanded: true,
              hint: const Text('Selecione uma tarefa'),
              items: _tarefas.map((Task tarefa) {
                return DropdownMenuItem<Task>(
                  value: tarefa,
                  child: Text(tarefa.title),
                );
              }).toList(),
              onChanged: (Task? novaTarefa) {
                if (novaTarefa != null) {
                  setState(() {
                    _tarefaSelecionada = novaTarefa;
                    _preencherCampos(novaTarefa);
                  });
                }
              },
            ),
            const SizedBox(height: 12),
            TextField(
              controller: controller,
              decoration: const InputDecoration(
                labelText: 'Titulo',
                labelStyle: TextStyle(color: Colors.white),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Prioridade',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                DropdownButton<TaskPriority>(
                  value: _selectedPriority,
                  items: TaskPriority.values.map((TaskPriority priority) {
                    IconData icon;
                    Color color;
                    String label;
                    switch (priority) {
                      case TaskPriority.high:
                        icon = Icons.flag;
                        color = Colors.red;
                        label = 'Alta';
                        break;
                      case TaskPriority.medium:
                        icon = Icons.flag;
                        color = Colors.yellow;
                        label = 'Média';
                        break;
                      case TaskPriority.low:
                      default:
                        icon = Icons.flag;
                        color = Colors.blue;
                        label = 'Baixa';
                        break;
                    }
                    return DropdownMenuItem<TaskPriority>(
                      value: priority,
                      child: Row(
                        children: [
                          Icon(icon, color: color, size: 18),
                          const SizedBox(width: 8),
                          Text(label),
                        ],
                      ),
                    );
                  }).toList(),
                  onChanged: (TaskPriority? newValue) {
                    if (newValue != null) {
                      setState(() {
                        _selectedPriority = newValue;
                      });
                    }
                  },
                ),
              ],
            ),
            Center(
              child: Column(
                children: [
                  const Text(
                    'Modo de Repetição',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  const Divider(color: Colors.white, thickness: 1),
                  DropdownButton<RepatedMode>(
                    value: _selectedRepatedMode,
                    items: RepatedMode.values.map((RepatedMode priority) {
                      return DropdownMenuItem<RepatedMode>(
                        value: priority,
                        child: Text(
                          priority.name == 'focusTotal'
                              ? 'Foco Total'
                              : priority.name,
                        ),
                      );
                    }).toList(),
                    onChanged: (RepatedMode? newValue) {
                      if (newValue != null) {
                        setState(() {
                          _selectedRepatedMode = newValue;
                        });
                      }
                    },
                  ),
                ],
              ),
            ),
            Center(
              child: Column(
                children: [
                  const Text(
                    'Lembrete',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  const Divider(color: Colors.white, thickness: 1),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        horaAtual,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.notifications,
                          color: notification
                              ? Colors.yellow
                              : const Color.fromARGB(255, 70, 70, 70),
                        ),
                        onPressed: () {
                          setState(() {
                            notification = !notification;
                          });
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      actions: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              style: TextButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
              ),
              child: const Text('Cancelar'),
            ),
            ElevatedButton(
              onPressed: () {
                // Aqui você pode salvar as alterações na tarefa selecionada
                Navigator.of(context).pop(controller.text);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                foregroundColor: Colors.white,
              ),
              child: const Text('Salvar'),
            ),
          ],
        ),
      ],
    );
  }
}