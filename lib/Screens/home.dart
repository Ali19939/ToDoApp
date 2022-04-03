import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/provider.dart';
import '../models/task.dart';
import '../widgets/task_tile.dart';
import 'add_task.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Task> taskList = <Task>[];
  TextEditingController controller = TextEditingController();
  @override
  void initState() {
    loadData();
    saveData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final myProvider = Provider.of<MyProvider>(context);

    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: const [
                      Icon(Icons.format_align_left, color: Colors.white),
                      SizedBox(width: 10),
                      Text(
                        'ToDayDo',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 37,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      IconButton(
                        onPressed: loadData,
                        icon: const Icon(
                          Icons.refresh,
                          color: Colors.white,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          myProvider.darkTheme = !myProvider.dark;
                        },
                        icon: myProvider.dark
                            ? const Icon(Icons.dark_mode)
                            : const Icon(Icons.light_mode, color: Colors.white),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 15),
              Row(
                children: [
                  const SizedBox(width: 10),
                  Text(
                    '${taskList.length} ${taskList.length >= 2 ? 'Tasks' : 'Task'}',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.9),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(10),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Theme.of(context).cardColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: taskList.isEmpty
                      ? const Center(child: Text('No Tasks Yet!'))
                      : TaskTile(
                          taskList: taskList,
                        ),
                ),
              ),
              const SizedBox(height: 25),
            ],
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FloatingActionButton(
          onPressed: () => openBottomSheet(),
          backgroundColor: Colors.indigo[500],
          child: const Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  void getController(String newTask) {
    setState(() {
      taskList.add(Task(name: newTask));
    });
    controller.clear();
    Navigator.pop(context);
    saveData();
    loadData();
  }

  void saveData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> spList =
        taskList.map((item) => json.encode(item.toMap())).toList();
    prefs.setStringList('taskList', spList);
  }

  void loadData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    List<String>? spList = prefs.getStringList('taskList');
    setState(() {
      taskList =
          spList!.map((item) => Task.fromMap(json.decode(item))).toList();
    });
  }

  void openBottomSheet() {
    showModalBottomSheet(
        isScrollControlled: true,
        backgroundColor: Theme.of(context).cardColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        context: context,
        builder: (ctx) {
          return AddTaskScreen(
            taskList: taskList,
            getController: getController,
            controller: controller,
          );
        });
    saveData();
    loadData();
  }
}
