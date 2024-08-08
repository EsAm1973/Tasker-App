import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:task_2_week13/Database/Db_Heloer.dart';
import 'package:task_2_week13/models/Task.dart';

class BottomSheetContent extends StatefulWidget {
  const BottomSheetContent({super.key});

  @override
  _BottomSheetContentState createState() => _BottomSheetContentState();
}

class _BottomSheetContentState extends State<BottomSheetContent> {
  DateTime? selectedDate;
  String? taskName;
  String? taskDays;
  int done = 0;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(10.0).copyWith(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: Container(
          padding: const EdgeInsets.all(10),
          child: Form(
            child: Column(
              //mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  decoration: const InputDecoration(
                    hintText: 'Task',
                  ),
                  onChanged: (val) {
                    setState(() {
                      taskName = val;
                    });
                  },
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    hintText: 'Number of Days',
                  ),
                  onChanged: (val) {
                    setState(() {
                      taskDays = val;
                    });
                  },
                ),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  children: [
                    IconButton(
                      onPressed: () async {
                        final DateTime? picked = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2020),
                          lastDate: DateTime(2030),
                        );
                        if (picked != null) {
                          setState(() {
                            selectedDate = picked;
                          });
                        }
                      },
                      icon: const Icon(
                        Icons.calendar_today_rounded,
                        color: Colors.blue,
                      ),
                    ),
                    Text(
                      selectedDate == null
                          ? 'No Date Selected'
                          : DateFormat.yMd().format(selectedDate!),
                    ),
                    const Spacer(),
                    MaterialButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text('Cancel'),
                    ),
                    MaterialButton(
                      onPressed: () async {
                        if (taskName == null ||
                            taskDays == null ||
                            selectedDate == null) {
                          Navigator.of(context).pop();
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Please fill in all fields'),
                            ),
                          );
                        } else {
                          Task task = Task({
                            'name': taskName,
                            'numberDays': taskDays,
                            'done': done,
                          });

                          var dbHelper = Db_Helper();
                          try {
                            await dbHelper.insertTask(task);
                          } catch (e) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Error: $e'),
                              ),
                            );
                          }
                          Navigator.of(context).pop();
                        }
                      },
                      child: const Text(
                        'Save',
                        style: TextStyle(color: Colors.blue),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
