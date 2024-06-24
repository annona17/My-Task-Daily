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
        backgroundColor: Colors.deepPurple[100],
        title: const Text('Add Task'),
      ),

      body: SingleChildScrollView(
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
                      const TitleDetail(title: "Title", icon: Icon(Icons.title)),
                      TextField(
                        onChanged: (value) => bloc.add(AddTaskChangeTittle(value)),
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Enter Title',
                        ),
                      ),
                      const TitleDetail(title: "Description", icon: Icon(Icons.create_rounded)),
                      TextField(
                        onChanged: (value) => bloc.add(AddTaskChangeDescription(value)),
                        minLines: 5,
                        maxLines: 5,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Enter Description',
                        ),
                      ),
                      const TitleDetail(title: "Date", icon: Icon(Icons.date_range)),
                      DatePicker(bloc: bloc),
                      const TitleDetail(title: "Time", icon: Icon(Icons.access_time)),
                      Row(
                        children: [
                          Expanded(child: TimePicker(isStartTime: true, bloc: bloc)),
                          const Padding(
                            padding: EdgeInsets.only(left: 10, right: 10),
                            child: Text('--'),
                          ),
                          Expanded(child: TimePicker(isStartTime: false, bloc: bloc)),
                        ],
                      ),
                      Priority(bloc: bloc),
                      ColorTask(bloc: bloc),
                      const SizedBox(height: 20),
                      Center(
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width * 2 / 3,
                          child: ElevatedButton(
                            onPressed: () {
                              bloc.add(AddTaskCreate(context));
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
