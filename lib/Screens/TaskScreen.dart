import 'package:flutter/material.dart';
import 'package:task_app/Model/Task.dart';
import 'package:task_app/Model/TaskCompents/TaskList.dart';
import 'package:task_app/Screens/NewTask.dart';

class TaskScreen extends StatelessWidget {
  const TaskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<Task> tasks = [
      Task(
          rateCount: RateCount.daily,
          category: Category.routine,
          count: 12,
          dateTime: DateTime.now(),
          title: "Youga"),
      Task(
          rateCount: RateCount.monthly,
          category: Category.studying,
          count: 5,
          dateTime: DateTime.now(),
          title: "Youga"),
      Task(
          rateCount: RateCount.monthly,
          category: Category.sport,
          count: 100,
          dateTime: DateTime.now(),
          title: "Youga"),
      Task(
          rateCount: RateCount.daily,
          category: Category.lifeStyle,
          count: 10,
          dateTime: DateTime.now(),
          title: "Youga"),
    ];
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          child: Icon(
            Icons.add,
            size: 28,
            color: Colors.white,
          ),
          backgroundColor: const Color.fromARGB(255, 149, 91, 236),
          onPressed: () {
            showModalBottomSheet(
              context: context,
              builder: (context) {
                return const NewTask();
              },
            );
          }),
      appBar: AppBar(
        title: const Text(
          "Welcome To TaskScreen",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color.fromARGB(255, 135, 99, 196),
      ),
      body: Column(children: [
        Expanded(
            child: TasksList(
          tasks: tasks,
        )),
      ]),
    );
  }
}
