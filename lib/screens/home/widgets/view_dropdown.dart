import 'package:flutter/material.dart';

import '../../../bloc/home/home_bloc.dart';

enum ViewFilter { All, Active, Completed, Fault }

class ViewDropdown extends StatefulWidget {
  final HomeBloc bloc;
  const ViewDropdown({super.key, required this.bloc});

  @override
  State<ViewDropdown> createState() => _ViewDropdownState();
}

class _ViewDropdownState extends State<ViewDropdown> {
  ViewFilter _view = ViewFilter.All;

  @override
  Widget build(BuildContext context) {
    return DropdownButton<ViewFilter>(
      value: _view,
      items: ViewFilter.values.map((ViewFilter value) {
        return DropdownMenuItem<ViewFilter>(
          value: value,
          child: Text(
              value.toString().split('.').last,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 13,
              ),
          ),
        );
      }).toList(),
      onChanged: (ViewFilter? value) {
        // setState(() {
        //   _view = value!;
        // });
        _view = value!;
        widget.bloc.add(HomeChangeFilter(_view));
      },
    );
  }
}
