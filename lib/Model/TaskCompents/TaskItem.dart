import 'package:flutter/material.dart';
import 'package:task_app/Model/Task.dart';

class TaskItem extends StatelessWidget {
  const TaskItem({super.key, required this.task});

  final Task task;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: ListTile(
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        tileColor: Colors.deepPurple.shade100,
        title: Text(
          task.title,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
        ),
        subtitle: Text(
          "${task.count} ${task.rateCount.name}",
          style: const TextStyle(
              fontSize: 16, color: Colors.purple, fontWeight: FontWeight.w500),
        ),
        trailing: SizedBox(
          width: 120,
          child: Row(
            children: [
              Icon(categoryIcon[task.category]),
              const SizedBox(
                width: 5,
              ),
              Text(
                "${task.formattedDate}",
                style: TextStyle(fontSize: 14),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
