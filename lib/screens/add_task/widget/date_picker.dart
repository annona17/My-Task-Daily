import 'package:flutter/material.dart';
import '../../../bloc/addtask/addtask_bloc.dart';

class DatePicker extends StatefulWidget {
  final AddTaskBloc bloc;
  const DatePicker({super.key, required this.bloc});

  @override
  State<DatePicker> createState() => _DatePickerState();
}

class _DatePickerState extends State<DatePicker> {
  final TextEditingController _dateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _dateController,
      readOnly: true,
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        hintText: "dd/MM/yyyy",
        suffixIcon: IconButton(
          onPressed: () async {
            final DateTime? pickedDate = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(2000),
                lastDate: DateTime(2030));
            if (pickedDate != null) {
              _dateController.text = "${pickedDate.day}/${pickedDate.month}/${pickedDate.year}";
              widget.bloc.add(AddTaskChangeDate(pickedDate));
            }
          },
          icon: const Icon(Icons.calendar_today),
        ),
      ),
    );
  }
}
