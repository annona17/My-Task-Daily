import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../bloc/addtask/addtask_bloc.dart';
import 'tittle.dart';

class ColorTask extends StatelessWidget {
  final AddTaskBloc bloc;
  const ColorTask({super.key, required this.bloc});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const TitleDetail(title: "Color", icon: Icon(Icons.color_lens)),
        Flexible(
          child: Wrap(
            spacing: 10,
            runSpacing: 10,
            children: Colors.primaries.map((Color color) {
              Color lighterColor = color.withOpacity(0.5);
              return FilterChip(
                label: const Text(" "),
                backgroundColor: lighterColor,
                selected: bloc.state.color == lighterColor,
                selectedColor: lighterColor,
                onSelected: (bool selected) {
                  bloc.add(AddTaskChangeColor(lighterColor));
                },
              );
            }).toList(),
          ),
        )
      ],
    );
  }
}