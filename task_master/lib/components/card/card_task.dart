import 'package:flutter/material.dart';
import 'package:task_master/model/task.dart';


class CardTask extends StatelessWidget {
  final String title;
  final bool completed;
  final TaskPriority priority;

  const CardTask({
    Key? key,
    required this.title,
    required this.priority,
    this.completed = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        completed ? Icons.check_circle : Icons.radio_button_unchecked,
        color: completed ? Colors.green : Colors.grey,
      ),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: completed ? Colors.grey : Colors.white,
              decoration: completed ? TextDecoration.lineThrough : null,
            ),
          ),
          Icon(
            priority == TaskPriority.high ? Icons.flag : Icons.flag,
            color: priority == TaskPriority.high ? Colors.red : priority == TaskPriority.low ?Colors.blue  : Colors.yellow,
          ),
        ],
      ),
    );
  }
}