import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoapp/screens/add_task/widget/tittle.dart';
import '../../../bloc/addtask/addtask_bloc.dart';

enum PriorityType { low, medium, high }

class Priority extends StatelessWidget {
  final AddTaskBloc bloc;
  const Priority({super.key, required this.bloc});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const TitleDetail(title: "Priority", icon: Icon(Icons.priority_high)),
        const SizedBox(width: 10),
        Wrap(
          spacing: 10,
          children: PriorityType.values.map((PriorityType priority) {
            return FilterChip(
              label: Text(priority.toString().split('.').last),
              selected: bloc.state.priority == priority.toString(),
              onSelected: (bool selected) {
                bloc.add(AddTaskChangePriority(priority));
              },
            );
          }).toList(),
        ),
      ],
    );
  }
}
