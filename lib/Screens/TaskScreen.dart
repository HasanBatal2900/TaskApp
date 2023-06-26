import 'package:flutter/material.dart';
import 'package:task_app/Model/Task.dart';
import 'package:task_app/Model/TaskCompents/TaskList.dart';
import 'package:task_app/Screens/NewTask.dart';

class TaskScreen extends StatefulWidget {
  const TaskScreen({super.key});

  @override
  State<TaskScreen> createState() => _TaskScreenState();
}

late AnimationController controller;
late Animation<double> animation;

class _TaskScreenState extends State<TaskScreen>
    with SingleTickerProviderStateMixin {
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

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1700))
      ..repeat(reverse: true);
    animation = CurvedAnimation(parent: controller, curve: Curves.fastOutSlowIn);
  }

  @override
  Widget build(BuildContext context) {
    void addTask(Task task) {
      setState(() {
        tasks.add(task);
      });
    }

    void removeTask(Task task) {
      int index = tasks.indexOf(task);
      setState(() {
        tasks.remove(task);
      });

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        animation:
            CurvedAnimation(parent: controller, curve: Curves.bounceInOut),
        duration: const Duration(seconds: 3),
        content: ScaleTransition(
          scale: animation,
          child: Container(
            child: Text("Are you  sure ?"),
          ),
        ),
        action: SnackBarAction(
            label: "Undo",
            onPressed: () {
              setState(() {
                tasks.insert(index, task);
              });
            }),
      ));
    }

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
                return NewTask(
                  addingTask: addTask,
                );
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
          removeTask: removeTask,
          tasks: tasks,
        )),
      ]),
    );
  }
}
