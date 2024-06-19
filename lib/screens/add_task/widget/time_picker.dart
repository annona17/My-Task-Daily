import 'package:flutter/material.dart';
import '../../../bloc/addtask/addtask_bloc.dart';

class TimePicker extends StatefulWidget {
  final bool isStartTime; // true if this is the start time, false if this is the end time
  final AddTaskBloc bloc;
  TimePicker({super.key, required this.isStartTime, required this.bloc});

  @override
  State<TimePicker> createState() => _TimePickerState();
}

class _TimePickerState extends State<TimePicker> {
  final TextEditingController _timeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _timeController,
      readOnly: true,
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        hintText: "hh:mm",
        suffixIcon: IconButton(
          onPressed: () async {
            final TimeOfDay? time = await showTimePicker(
                context: context, initialTime: TimeOfDay.now());
            if (time != null) {
              _timeController.text = '${time.hour}:${time.minute}';
              if (widget.isStartTime) {
                widget.bloc.add(AddTaskChangeStartTime(time));
              } else {
                widget.bloc.add(AddTaskChangeEndTime(time));
              }
            }
          },
          icon: const Icon(Icons.access_time),
        ),
      ),
    );
  }
}
