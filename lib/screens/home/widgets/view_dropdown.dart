import 'package:flutter/material.dart';

import '../../../bloc/home/home_bloc.dart';

enum ViewFilter { all, active, completed}

class ViewDropdown extends StatefulWidget {
  final HomeBloc bloc;
  const ViewDropdown({super.key, required this.bloc});

  @override
  State<ViewDropdown> createState() => _ViewDropdownState();
}

class _ViewDropdownState extends State<ViewDropdown> {
  ViewFilter _view = ViewFilter.all;

  @override
  Widget build(BuildContext context) {
    return DropdownButton<ViewFilter>(
      value: _view,
      items: ViewFilter.values.map((ViewFilter value) {
        return DropdownMenuItem<ViewFilter>(
          value: value,
          child: Text(
              value.toString().split('.').last.inCaps,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 13,
              ),
          ),
        );
      }).toList(),
      onChanged: (ViewFilter? value) {
        _view = value!;
        widget.bloc.add(HomeChangeFilter(_view));
      },
    );
  }
}

extension CapExtension on String {
  String get inCaps => '${this[0].toUpperCase()}${substring(1)}';
}

