import 'package:flutter/material.dart';
import 'package:task_master/components/card/card_task.dart';
import 'package:task_master/model/task.dart';
// Widget para o card do dia, recebendo uma lista de tarefas
class DayTasksCard extends StatelessWidget {
  final String date;
  final List<Task> tasks;

  const DayTasksCard({
    Key? key,
    required this.date,
    required this.tasks,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color:  const Color.fromARGB(150, 0, 0, 0),
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              date,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
            ),
            const Divider(),
            ...tasks.map((task) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              child: CardTask(
                title: task.title ,
                priority: task.priority,
                completed: task.completed,
              ),
            )),
          ],
        ),
      ),
    );
  }
}
