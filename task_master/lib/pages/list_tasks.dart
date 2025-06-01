import 'package:flutter/material.dart';
import 'package:task_master/components/card/day_tasks_card.dart';
import 'package:task_master/model/task.dart';

class ListTasksPage extends StatefulWidget {
  const ListTasksPage({Key? key}) : super(key: key);

  @override
  _ListTasksPageState createState() => _ListTasksPageState();
}

class _ListTasksPageState extends State<ListTasksPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:const Color.fromARGB(255, 48, 48, 48) ,
      body: ListView(
        children: [
          DayTasksCard(
            date: '28 maio 2025',
            tasks: [
              Task(
                title: 'Tarefa 1',
                priority: TaskPriority.low,
                completed: false,
              ),
              Task(
                title: 'Tarefa 2',
                priority: TaskPriority.medium,
                completed: true,
              ),
               Task(
                title: 'Tarefa 3',
                priority: TaskPriority.high,
                completed: true,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
