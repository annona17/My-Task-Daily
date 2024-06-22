import 'package:flutter/material.dart';

import '../../../bloc/home/home_bloc.dart';

class PickDateToView extends StatefulWidget {
  final HomeBloc bloc;
  const PickDateToView({super.key, required this.bloc});

  @override
  State<PickDateToView> createState() => _PickDateToViewState();
}

class _PickDateToViewState extends State<PickDateToView> {
  DateTime selectedDate = DateTime.now();
  @override

  Widget build(BuildContext context) {
    return ListTile(
      leading: IconButton(
        icon: const Icon(Icons.calendar_today),
        onPressed: () async {
          final DateTime? pickedDate = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime(2000),
              lastDate: DateTime(2030));
          if (pickedDate != null) {
            setState((){
              selectedDate = pickedDate;
            });
            widget.bloc.add(HomeChangeDate(selectedDate));
          }
        },
      ),
      title: Text(formatDate(selectedDate),
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
      );
  }
}

String formatDate(DateTime date) {
  final now = DateTime.now();
  final today = DateTime(now.year, now.month, now.day);
  final tomorrow = DateTime(now.year, now.month, now.day + 1);
  final yesterday = DateTime(now.year, now.month, now.day - 1);

  final aDate = DateTime(date.year, date.month, date.day);

  if (aDate == today) {
    return 'Today';
  } else if (aDate == tomorrow) {
    return 'Tomorrow';
  } else if (aDate == yesterday) {
    return 'Yesterday';
  } else {
    return "${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}";
  }
}

