import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../bloc/addtask/addtask_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'widget/color_task.dart';
import 'widget/date_picker.dart';
import 'widget/priority_choice.dart';
import 'widget/time_picker.dart';
import 'widget/tittle.dart';

class AddTask extends StatefulWidget {
  const AddTask({super.key});

  @override
  State<AddTask> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Task'),
      ),
      body: SingleChildScrollView( // Add SingleChildScrollView here
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              BlocBuilder<AddTaskBloc, AddTaskState>(
                builder: (context, state) {
                  final bloc = context.read<AddTaskBloc>();
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const TitleDetail(title: "Tittle", icon: Icon(Icons.title)),
                      TextField(
                        onChanged: (value) => bloc.add(AddTaskChangeTittle(value)),
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Enter Title',
                        ),
                      ),
                      const SizedBox(height: 10), // Add spacing between elements
                      const TitleDetail(title: "Description", icon: Icon(Icons.create_rounded)),
                      const SizedBox(height: 10),
                      TextField(
                        onChanged: (value) => bloc.add(AddTaskChangeDescription(value)),
                        minLines: 5,
                        maxLines: 5,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Enter Description',
                        ),
                      ),
                      const SizedBox(height: 10),
                      const TitleDetail(title: "Date", icon: Icon(Icons.date_range)),
                      const SizedBox(height: 10),
                      DatePicker(bloc: bloc),
                      const SizedBox(height: 10),
                      const TitleDetail(title: "Time", icon: Icon(Icons.access_time)),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Expanded(child: TimePicker(isStartTime: true, bloc: bloc)),
                          const SizedBox(width: 10),
                          const Text('--'),
                          const SizedBox(width: 10),
                          Expanded(child: TimePicker(isStartTime: false, bloc: bloc)),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Priority(bloc: bloc),
                      const SizedBox(height: 10),
                      ColorTask(bloc: bloc),
                      const SizedBox(height: 20),
                      Center(
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width * 2 / 3,
                          child: ElevatedButton(
                            onPressed: () {
                              bloc.add(AddTaskCreate());
                            },
                            child: const Text('Create Task'),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
