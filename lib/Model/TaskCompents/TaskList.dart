import 'package:flutter/material.dart';
import 'TaskItem.dart';
import 'package:task_app/Model/Task.dart';

class TasksList extends StatefulWidget {
  const TasksList({super.key, required this.tasks, required this.removeTask});
  final List<Task> tasks;
  final void Function(Task) removeTask;

  @override
  State<TasksList> createState() => _TasksListState();
}

class _TasksListState extends State<TasksList> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.tasks.length,
      itemBuilder: (context, index) {
        return Dismissible(
            background: Container(
              margin: const EdgeInsets.all(5.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color:const Color.fromARGB(255, 171, 137, 242),
              ),
            ),
            onDismissed: (direction) {
              setState(() {
                widget.removeTask(widget.tasks[index]);
              });
            },
            key: ValueKey(widget.tasks[index]),
            child: TaskItem(task: widget.tasks[index]));
      },
    );
  }
}
