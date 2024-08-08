import 'package:flutter/material.dart';
import 'package:task_2_week13/Database/Db_Heloer.dart';
import 'package:task_2_week13/models/Task.dart';

class TaskItem extends StatefulWidget {
  const TaskItem({super.key, required this.task});
  final Task task;

  @override
  State<TaskItem> createState() => _TaskItemState();
}

class _TaskItemState extends State<TaskItem> {
  late bool isChecked;

  @override
  void initState() {
    super.initState();
    isChecked = widget.task.done == 1;
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding:
          const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
      leading: Transform.scale(
        scale: 1.7, // Adjust the scale value to increase/decrease size
        child: Checkbox(
          side: const BorderSide(width: 0.9),
          shape: const CircleBorder(),
          activeColor: Colors.blue,
          value: isChecked,
          onChanged: (bool? value) async {
            setState(() {
              isChecked = value!;
            });
            var dbHelper = Db_Helper();
            await dbHelper.updateTaskDone(widget.task.id, isChecked ? 1 : 0);
          },
        ),
      ),
      title: Text(
        widget.task.name,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
      subtitle: Text(widget.task.numberDays),
    );
  }
}
