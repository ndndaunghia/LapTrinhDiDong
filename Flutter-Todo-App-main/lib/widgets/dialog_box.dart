import 'package:flutter/material.dart';
import 'my_button.dart';

class DialogBox extends StatelessWidget {
  final controller;
  final selectDate;
  VoidCallback onSaved;
  VoidCallback onCancel;
  VoidCallback datePicker;
  DialogBox(
      {super.key,
      required this.controller,
      required this.selectDate,
      required this.onSaved,
      required this.onCancel,
      required this.datePicker});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.lightBlue,
      content: SizedBox(
        height: 200,
        child:
            Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          TextField(
            controller: controller,
            decoration: const InputDecoration(
                icon: Icon(Icons.task),
                border: UnderlineInputBorder(),
                hintText: "Add a new Task"
                // labelText: "Add a new Task"
                ),
          ),
          TextField(
            controller: selectDate,
            onTap: () {
              datePicker();
            },
            keyboardType: TextInputType.none,
            decoration: const InputDecoration(
                icon: Icon(Icons.calendar_today),
                border: UnderlineInputBorder(),
                hintText: "Add a deadline"),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              MyButton(text: "Save", onPressed: onSaved),
              MyButton(text: "Cancel", onPressed: onCancel)
            ],
          )
        ]),
      ),
    );
  }
}
