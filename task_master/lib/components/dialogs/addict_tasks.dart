import 'package:flutter/material.dart';
import 'package:task_master/model/task.dart';

class AddTaskDialog extends StatelessWidget {
  final TextEditingController controller = TextEditingController();
  final DateTime? dateTask;

  AddTaskDialog({super.key, this.dateTask});

  @override
  Widget build(BuildContext context) {
    String dataHoje = dateTask != null
        ? '${dateTask!.day.toString().padLeft(2, '0')} - ${dateTask!.month.toString().padLeft(2, '0')}}'
        : 'Data não selecionada';

    return AlertDialog(
      
      backgroundColor:  Colors.grey,
      title: Container(
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 40),
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
      content: Column(
        children: [
          TextField(
            controller: controller,
            decoration: const InputDecoration(
              labelText: 'Titulo',
            ),
          ),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Prioridade',
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
            DropdownButton<TaskPriority>(
              value: TaskPriority.medium,
              items: TaskPriority.values.map((TaskPriority priority) {
                return DropdownMenuItem<TaskPriority>(
                  value: priority,
                  child: Text(priority.name),
                );
              }).toList(),
              onChanged: (TaskPriority? newValue) {
              },
            ),
          ],
        ),
        Text(
          'Modo de Repetição',
          style: TextStyle(color: Colors.white, fontSize: 14
          ),
        ),
        DropdownButton<RepatedMode>(
              value: RepatedMode.focusTotal,
              items: RepatedMode.values.map((RepatedMode priority) {
                return DropdownMenuItem<RepatedMode>(
                  value: priority,
                  child: Text(priority.name),
                );
              }).toList(),
              onChanged: (RepatedMode? newValue) {
              },
            ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancelar'),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop(controller.text);
          },
          child: const Text('Salvar'),
        ),
      ],
    );
  }
}