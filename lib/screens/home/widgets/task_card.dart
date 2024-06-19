import 'package:flutter/material.dart';

import '../../../data/model/task.dart';

class TaskCard extends StatelessWidget {
  final Task task;
  const TaskCard({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: const ValueKey("Task"),
      onDismissed: (direction) {
        // Remove the item from the data source.
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
                title: Text(task.title),
                subtitle: Text(task.description),
                trailing: Checkbox(
                  value: false,
                  onChanged: (bool? value) {},
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Container(
                      color: Colors.deepPurple[100],
                      padding: const EdgeInsets.all(15),
                        child: Text(task.priority),
                    ),
                    const SizedBox(width: 10),
                    Container(
                      color: Colors.deepPurple[100],
                      padding: const EdgeInsets.all(15),
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
