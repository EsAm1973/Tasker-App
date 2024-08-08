import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:task_2_week13/Database/Db_Heloer.dart';
import 'package:task_2_week13/Widgets/BottomSheet.dart';
import 'package:task_2_week13/Widgets/TaskListItem.dart';
import 'package:task_2_week13/models/Task.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Task> _tasks = [];

  @override
  void initState() {
    super.initState();
    _fetchTasks();
  }

  Future<void> _fetchTasks() async {
    var dbHelper = Db_Helper();
    List<Map<String, dynamic>> tasks = await dbHelper.getTasks();
    setState(() {
      _tasks = tasks.map((task) => Task.fromMap(task)).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    String formattedDateDay = DateFormat.d().format(now);
    String formattedDateYear = DateFormat.y().format(now);
    String formattedDateMonth = DateFormat.MMM().format(now);
    String formattedDateDayName = DateFormat.EEEE().format(now).toUpperCase();

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
          title: const Text(
            'Tasker',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
          ),
        ),
        drawer: const Drawer(),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
          ),
          onPressed: () {
            showModalBottomSheet(
              context: context,
              builder: (context) => const BottomSheetContent(),
            ).then((_) => _fetchTasks()); // Refresh tasks after closing
          },
          child: const Icon(
            Icons.add,
            size: 30,
          ),
        ),
        body: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              alignment: Alignment.center,
              width: double.infinity,
              height: 130,
              color: Colors.blue,
              child: Row(
                children: [
                  Text(
                    formattedDateDay,
                    style: const TextStyle(
                      fontSize: 50,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        formattedDateMonth,
                        style: const TextStyle(color: Colors.white),
                      ),
                      Text(
                        formattedDateYear,
                        style: const TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                  const Spacer(),
                  Text(
                    formattedDateDayName,
                    style: const TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: _tasks.isEmpty
                  ? const Center(
                      child: Text('No Tasks Available'),
                    )
                  : ListView.builder(
                      itemCount: _tasks.length,
                      itemBuilder: (context, index) {
                        Task task = _tasks[index];
                        return TaskItem(
                          task: task,
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
