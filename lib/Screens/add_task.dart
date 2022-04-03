import 'package:flutter/material.dart';

import '../models/task.dart';

// ignore: use_key_in_widget_constructors
class AddTaskScreen extends StatelessWidget {
  final List<Task> taskList;
  final Function(String controller) getController;
  final TextEditingController controller;

  // ignore: use_key_in_widget_constructors
  const AddTaskScreen({
    required this.taskList,
    required this.getController,
    required this.controller,
  });
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          color: Theme.of(context).cardColor,
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const SizedBox(height: 10),
              const Text(
                'Add Task',
                style: TextStyle(color: Colors.indigo, fontSize: 30),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: TextField(
                  controller: controller,
                  autofocus: true,
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    controller.text == ''
                        ? Navigator.pop(context)
                        : getController(controller.text);
                  },
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.teal)),
                  child: const Text(
                    'Add',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
