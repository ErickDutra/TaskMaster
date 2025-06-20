import 'package:flutter/material.dart';
import 'package:task_master/model/task.dart';

class AddTaskDialog extends StatefulWidget {
  final String? dateTask;

  const AddTaskDialog({super.key, this.dateTask});

  @override
  State<AddTaskDialog> createState() => _AddTaskDialogState();
}

class _AddTaskDialogState extends State<AddTaskDialog> {
  final TextEditingController controller = TextEditingController();
  bool notification = false;

  TaskPriority _selectedPriority = TaskPriority.medium;
  RepatedMode _selectedRepatedMode = RepatedMode.focusTotal;

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
        height: 290,
        child: ListView(
          shrinkWrap: true,
          children: [
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
                  items:
                      TaskPriority.values.map((TaskPriority priority) {
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
                    items:
                        RepatedMode.values.map((RepatedMode priority) {
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
                          color:
                              notification
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
