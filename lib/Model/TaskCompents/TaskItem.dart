import 'package:flutter/material.dart';
import 'package:task_app/Model/Task.dart';
import 'package:task_app/Model/updateTaskData.dart';
import 'package:task_app/Screens/UpdateTask.dart';

class TaskItem extends StatefulWidget {
  const TaskItem(
      {super.key,
      required this.task,
      required this.updateTask,
      required this.index});
  final int index;
  final Task task;
  final void Function(Task, int) updateTask;
  @override
  State<TaskItem> createState() => _TaskItemState();
}

class _TaskItemState extends State<TaskItem>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation animation;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 500));
    animation = CurvedAnimation(parent: controller, curve: Curves.easeInCirc);
    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: ListTile(
        onTap: () {
          Navigator.push(
              context,
              PageRouteBuilder(
                settings: RouteSettings(
                    arguments:
                        updateTaskData(index: widget.index, task: widget.task)),
                transitionDuration: const Duration(milliseconds: 600),
                transitionsBuilder:
                    (context, animation, secondaryAnimation, child) {
                  return ScaleTransition(
                    scale: animation,
                    child: child,
                  );
                },
                pageBuilder: (context, animation, secondaryAnimation) {
                  return UpdateScreen(updateTask: widget.updateTask);
                },
              ));
        },
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        tileColor: Colors.deepPurple.shade100,
        title: Text(
          widget.task.title,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
        ),
        subtitle: Text(
          "${widget.task.count} ${widget.task.rateCount.name}",
          style: const TextStyle(
              fontSize: 16, color: Colors.purple, fontWeight: FontWeight.w500),
        ),
        trailing: SizedBox(
          width: 120,
          child: Row(
            children: [
              Icon(categoryIcon[widget.task.category]),
              const SizedBox(
                width: 5,
              ),
              Text(
                "${widget.task.formattedDate}",
                style: const TextStyle(fontSize: 14),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
