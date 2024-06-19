import 'package:flutter/material.dart'; 

enum ViewFilter { All, Active, Completed, Fault }

class ViewDropdown extends StatefulWidget {
  const ViewDropdown({super.key});

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
        setState(() {
          _view = value!;
        });
      },
    );
  }
}
