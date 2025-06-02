import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:task_master/components/dialogs/addict_tasks.dart';
import 'package:task_master/components/dialogs/edit_tasks.dart';

class CalendarPageStateless extends StatefulWidget {
  const CalendarPageStateless({Key? key}) : super(key: key);

  @override
  State<CalendarPageStateless> createState() => _CalendarPageStatelessState();
}

class _CalendarPageStatelessState extends State<CalendarPageStateless> {
  Map<DateTime, List<String>> feriados = {};
  DateTime today = DateTime.now();
  DateTime focusedMonth = DateTime.now();
  String dataHoje = '';

  @override
  void initState() {
    super.initState();
    lerFeriados();
    refreshData(today);
  }

  Future<void> refreshData(today) async {
    final String resposta = await rootBundle.loadString('assets/meses.json');
    final dados = json.decode(resposta);
    final List<String> listaMeses =
        (dados['meses'] as List).map((e) => e.toString()).toList();
    setState(() {
      dataHoje = '${today.day} - ${listaMeses[today.month - 1]}';
    });
  }

  Future<void> lerFeriados() async {
    final String resposta = await rootBundle.loadString('assets/feriados.json');
    final dados = json.decode(resposta);
    //  [{"data": "2025-01-01", "nome": "Ano Novo"}, ...]
    Map<DateTime, List<String>> mapa = {};
    for (var item in dados) {
      DateTime data = DateTime(DateTime.now().year, item['mes'], item['dia']);
      mapa[data] = [item['nome']];
    }
    setState(() {
      feriados = mapa;
    });
  }

  List<MapEntry<DateTime, List<String>>> feriadosDoMes(DateTime mes) {
    return feriados.entries
        .where(
          (entry) => entry.key.year == mes.year && entry.key.month == mes.month,
        )
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 48, 48, 48),
      body: Container(
        height: 450,
        decoration: BoxDecoration(
          color: const Color.fromARGB(150, 0, 0, 0),
          borderRadius: BorderRadius.circular(16),
        ),
        margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            TableCalendar(
              focusedDay: focusedMonth,
              onPageChanged: (focused) {
                setState(() {
                  focusedMonth = focused;
                });
              },
              eventLoader: (day) {
                return feriados[DateTime(day.year, day.month, day.day)] ?? [];
              },
              daysOfWeekStyle: const DaysOfWeekStyle(
                weekdayStyle: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
                weekendStyle: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              headerStyle: const HeaderStyle(
                titleCentered: true,
                formatButtonVisible: false,
                titleTextStyle: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                leftChevronIcon: Icon(Icons.chevron_left, color: Colors.white),
                rightChevronIcon: Icon(
                  Icons.chevron_right,
                  color: Colors.white,
                ),
              ),
              calendarStyle: CalendarStyle(
                todayDecoration: BoxDecoration(color: Colors.transparent),
                selectedDecoration: BoxDecoration(
                  color: Colors.green,
                  shape: BoxShape.circle,
                ),
                defaultTextStyle: const TextStyle(color: Colors.white),
                weekendTextStyle: const TextStyle(color: Colors.white),
                outsideTextStyle: const TextStyle(color: Colors.grey),
              ),
              calendarBuilders: CalendarBuilders(
                markerBuilder: (context, date, events) {
                  if (events.isNotEmpty) {
                    return Positioned(
                      bottom: 1,
                      child: Container(
                        width: 6,
                        height: 6,
                        decoration: const BoxDecoration(
                          color: Colors.transparent,
                          shape: BoxShape.circle,
                        ),
                      ),
                    );
                  }
                  return null;
                },
                defaultBuilder: (context, date, _) {
                  if (feriados[DateTime(date.year, date.month, date.day)] !=
                      null) {
                    return Container(
                      decoration: BoxDecoration(
                        color: Colors.deepPurple,
                        shape: BoxShape.circle,
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        '${date.day}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    );
                  }
                  return null;
                },
              ),
              firstDay: DateTime(2000),
              lastDay: DateTime(2100),

              selectedDayPredicate: (day) => isSameDay(day, today),
              onDaySelected: (selectedDay, focusedDay) {
                setState(() {
                  today = selectedDay;
                  focusedMonth = focusedDay;
                });
                refreshData(today);
              },
            ),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(0),

                children:
                    feriadosDoMes(focusedMonth).map((entry) {
                      final data = entry.key;
                      final nomes = entry.value.join(', ');
                      return ListTile(
                        dense: true,
                        visualDensity: VisualDensity.compact,
                        minVerticalPadding: 0,
                        minTileHeight: 0,
                        title: Text(
                          '${data.day} - $nomes',
                          style: const TextStyle(color: Colors.white),
                        ),
                      );
                    }).toList(),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
        onPressed: () {
          showModalBottomSheet(
            context: context,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
            ),
            backgroundColor: const Color.fromARGB(255, 48, 48, 48),
            builder: (context) {
              return Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                    
                      height: 30,
                      width: 350,
                      padding: const EdgeInsets.symmetric(
                        vertical: 5,
                        horizontal:
                            32, // Valor reduzido para evitar quebra de linha
                      ),
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        dataHoje,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const Divider(color: Colors.white, thickness: 1),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey,
                        padding: const EdgeInsets.symmetric(
                          vertical: 7,
                          horizontal: 125,
                        ),
                      ),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) => AddTaskDialog(dateTask: dataHoje),
                        );
                      },
                      child: const Text(
                        'Criar Tarefa',
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ),

                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey,
                        padding: const EdgeInsets.symmetric(
                          vertical: 7,
                          horizontal: 123,
                        ),
                      ),
                      onPressed: () {
                       showDialog(
                          context: context,
                          builder: (context) => EditTaskDialog(dateTask: dataHoje),
                        );
                      },
                      child: const Text(
                        'Editar Tarefa',
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ),

                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey,
                        padding: const EdgeInsets.symmetric(
                          vertical: 7,
                          horizontal: 50,
                        ),
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Text(
                            'Completar Todas',
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                          const Icon(
                            Icons.check_circle,
                            color: Colors.white,
                            size: 20,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
        backgroundColor: Colors.green,
        child: const Icon(Icons.create),
      ),
    );
  }
}
