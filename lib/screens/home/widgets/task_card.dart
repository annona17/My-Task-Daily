import 'package:flutter/material.dart';

import '../../../bloc/home/home_bloc.dart';
import '../../../data/model/task.dart';

class TaskCard extends StatefulWidget {
  final Task task;
  final HomeBloc bloc;
  const TaskCard({super.key, required this.task, required this.bloc});

  @override
  State<TaskCard> createState() => _TaskCardState();
}

class _TaskCardState extends State<TaskCard> {
  bool _isDimissed = false;
  @override
  Widget build(BuildContext context) {
    if (_isDimissed) {
      return const SizedBox.shrink();
    }
    return Dismissible(
      key: Key(widget.task.id.toString()),
      onDismissed: (direction) {
        if (mounted){
          setState(() {
            _isDimissed = true;
          });
        }
        widget.bloc.add(HomeDeleteTask(widget.task));
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Task ${widget.task.title} deleted"),
            action: SnackBarAction(
              label: "Undo",
              onPressed: () {
                if (mounted) {
                  setState(() {
                    _isDimissed = false;
                  });
                }
                widget.bloc.add(HomeUndoDelete(widget.task));
              },
            ),
          ),
        );
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
          color: widget.task.colorTask,
          child: Column(
            children: [
              ListTile(
                title: Text(widget.task.title, style: const TextStyle(fontWeight: FontWeight.bold)),
                subtitle: Text(widget.task.description, style: const TextStyle(fontStyle: FontStyle.italic)),
                trailing: Checkbox(
                  value: widget.task.status == "Active"? false : true,
                  onChanged: (bool? value) {
                    if (value == true) {
                      widget.bloc.add(HomeCompleteTask(widget.task));
                    } else {
                      widget.bloc.add(HomeUndoComplete(widget.task));
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
                        child: Text(widget.task.priority.toString().split('.').last),
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
                          Text("${widget.task.startTime} - ${widget.task.endTime}"),
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
