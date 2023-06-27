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

late AnimationController upController;
late Animation<double> upAnimation;

class _TaskScreenState extends State<TaskScreen> with TickerProviderStateMixin {
  List<Task> tasks = [
    Task(
        rateCount: RateCount.daily,
        category: Category.studying,
        count: 12,
        dateTime: DateTime.now(),
        title: "Study"),
    Task(
        rateCount: RateCount.monthly,
        category: Category.sport,
        count: 5,
        dateTime: DateTime.now(),
        title: "Play Football"),
    Task(
        rateCount: RateCount.daily,
        category: Category.lifeStyle,
        count: 100,
        dateTime: DateTime.now(),
        title: "Yoga"),
    Task(
        rateCount: RateCount.daily,
        category: Category.lifeStyle,
        count: 10,
        dateTime: DateTime.now(),
        title: "Youga"),
  ];

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1700))
      ..repeat(reverse: true);
    animation =
        CurvedAnimation(parent: controller, curve: Curves.fastOutSlowIn);
    upController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 700), value: 0.9)
      ..repeat(reverse: true, max: 1, min: 0.9);

    upAnimation = CurvedAnimation(parent: upController, curve: Curves.bounceIn);
  }

  @override
  Widget build(BuildContext context) {
    Widget contentWidget = const Center(
      child: Text(
        "There is no Tasks try to add some ",
        textAlign: TextAlign.center,
      ),
    );
    void updateTask(Task task, int index) {
      setState(() {
        tasks[index] = task;
      });
    }

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
        duration: const Duration(seconds: 2),
        content: ScaleTransition(
          scale: animation,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: const Text("Are you  sure ?"),
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

    if (!tasks.isEmpty) {
      setState(() {
        contentWidget = TasksList(
            tasks: tasks, removeTask: removeTask, updateTask: updateTask);
      });
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
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          "Welcome To TaskScreen",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color.fromARGB(255, 135, 99, 196),
      ),
      body: SingleChildScrollView(
        child: Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 600, child: contentWidget),
              AnimatedBuilder(
                animation: upAnimation,
                builder: (context, child) {
                  return ScaleTransition(
                    scale: upAnimation,
                    child: Padding(
                      padding: EdgeInsets.only(bottom: 60),
                      child: Align(
                        alignment: Alignment.center,
                        child: Container(
                          padding: const EdgeInsets.all(15.0),
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 145, 80, 243),
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          child: Text(
                            "you have a number:${tasks.length}",
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
