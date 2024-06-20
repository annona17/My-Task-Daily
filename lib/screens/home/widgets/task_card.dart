import 'package:flutter/material.dart';

import '../../../bloc/home/home_bloc.dart';
import '../../../data/model/task.dart';

class TaskCard extends StatelessWidget {
  final Task task;
  final HomeBloc bloc;
  const TaskCard({super.key, required this.task, required this.bloc});

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: const ValueKey("task"),
      onDismissed: (direction) {
        bloc.add(HomeDeleteTask(task));
      },
      background: Container(
        color: Colors.red[300],
        child: const Icon(Icons.delete),
      ),
      child: GestureDetector(
        onTap: () {
          //Navigator.pushNamed(context, '/add_task');
        },
        child: Card(
          color: task.colorTask,
          child: Column(
            children: [
              ListTile(
                title: Text(task.title, style: const TextStyle(fontWeight: FontWeight.bold)),
                subtitle: Text(task.description, style: const TextStyle(fontStyle: FontStyle.italic)),
                trailing: Checkbox(
                  value: task.status == "Active"? false : true,
                  onChanged: (bool? value) {
                    if (value == true) {
                      bloc.add(HomeCompleteTask(task));
                    } else {
                      bloc.add(HomeUndoComplete(task));
                    }
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          color: Colors.deepPurple[100],
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(task.priority.toString().split('.').last),
                    ),
                    const SizedBox(width: 10),
                    Container(
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        color: Colors.deepPurple[100],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.timer_outlined),
                          Text("${task.startTime} - ${task.endTime}"),
                        ],
                      )
                    ),
                  ],
                ),
              )
            ],
          ),

        ),
      ),
    );
  }
}
