import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/task.dart';

// ignore: use_key_in_widget_constructors
class TaskTile extends StatefulWidget {
  final List<Task> taskList;
  // ignore: use_key_in_widget_constructors
  const TaskTile({
    required this.taskList,
  });

  @override
  State<TaskTile> createState() => _TaskTileState();
}

class _TaskTileState extends State<TaskTile> {
  @override
  Widget build(BuildContext context) {
    void saveData() async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      List<String> spList =
          widget.taskList.map((item) => json.encode(item.toMap())).toList();
      prefs.setStringList('taskList', spList);
    }

    void removeItem(Task item) async {
      SharedPreferences prefs = await SharedPreferences.getInstance();

      setState(() {
        widget.taskList.remove(item);
        List<String> spList =
            widget.taskList.map((item) => json.encode(item.toMap())).toList();
        prefs.setStringList('taskList', spList);
        saveData();
      });
    }

    return ListView.builder(
      itemBuilder: ((ctx, index) {
        return Dismissible(
          key: UniqueKey(),
          onDismissed: (direction) {
            setState(() {
              removeItem(widget.taskList[index]);
            });
          },
          background: Container(
            color: Colors.red,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  color: Colors.red,
                  child: Row(
                    children: const [
                      Icon(
                        Icons.delete,
                        color: Colors.white,
                      ),
                      Text(
                        'Delete',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      )
                    ],
                  ),
                  padding: const EdgeInsets.only(left: 10),
                ),
                Container(
                  color: Colors.red,
                  child: Row(
                    children: const [
                      Text(
                        'Delete',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Icon(
                        Icons.delete,
                        color: Colors.white,
                      ),
                    ],
                  ),
                  padding: const EdgeInsets.only(right: 10),
                ),
              ],
            ),
          ),
          child: CheckboxListTile(
            value: widget.taskList[index].isCompleted,
            onChanged: (bool? value) {
              setState(() {
                widget.taskList[index].isCompleted = value!;
              });
              saveData();
            },
            title: Text(
              widget.taskList[index].name,
              style: widget.taskList[index].isCompleted == false
                  ? Theme.of(context).textTheme.subtitle1
                  : const TextStyle(
                      decoration: TextDecoration.lineThrough,
                      color: Colors.grey),
            ),
            activeColor: Colors.teal,
          ),
        );
      }),
      itemCount: widget.taskList.length,
    );
  }
}
