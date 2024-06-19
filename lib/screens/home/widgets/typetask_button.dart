import 'package:flutter/material.dart';

class TypeTaskButton extends StatefulWidget {
  final String typeTask;
  final int numberTask;
  const TypeTaskButton({super.key, required this.typeTask, required this.numberTask});

  @override
  State<TypeTaskButton> createState() => _TypeTaskButtonState();
}

class _TypeTaskButtonState extends State<TypeTaskButton> {

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        OutlinedButton(
          onPressed: (){},
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(widget.typeTask),
              const SizedBox(width: 10),
              Container(
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: Colors.deepPurple[100],
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: Text(widget.numberTask.toString())
              ),
            ],
          ),
        ),
        const SizedBox(width: 10,)
      ],
    );
  }
}
