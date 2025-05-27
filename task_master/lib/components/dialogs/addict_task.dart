import 'package:flutter/material.dart';


class AddTaskDialog extends StatelessWidget {
  final  controller = TextEditingController();
  final DateTime? dateTask;
  

  AddTaskDialog({super.key, this.dateTask});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Nova Tarefa'),
      content: TextField(
        controller: controller,
        decoration: const InputDecoration(
          labelText: 'Descrição da tarefa',
        ),
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