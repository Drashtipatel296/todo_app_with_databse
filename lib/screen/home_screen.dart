import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/database_controller.dart';
import '../model/database_model.dart';
import 'edir_screen.dart';
import 'task_screen.dart';

class HomeScreen extends StatelessWidget {

  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TaskController taskController = Get.put(TaskController());
    return Scaffold(
      appBar: AppBar(
        leading: Icon(
          Icons.menu,
        ),
        centerTitle: true,
        title: Text(
          'TODO App',
        ),
      ),
      body: Obx(() {
        if (taskController.tasks.isEmpty) {
          return Center(child: CircularProgressIndicator());
        }
        return ListView.builder(
          itemCount: taskController.tasks.length,
          itemBuilder: (context, index) {
            final task = taskController.tasks[index];
            return TaskCard(task: task);
          },
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showAddTaskDialog(context);
        },
        child: Icon(
          Icons.add,
          size: 30,
        ),
      ),

    );
  }
}

class TaskCard extends StatelessWidget {
  final Todo task;

  TaskCard({required this.task});

  @override
  Widget build(BuildContext context) {
    final TaskController taskController = Get.find();

    return Card(
      color: getColorForPriority(task.priority),
      child: ListTile(
        title: Text(task.taskName),
        subtitle: Text(task.note),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: Icon(Icons.edit),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return EditScreen(task: task);
                  },
                );
              },
            ),
            Checkbox(
              value: task.isDone,
              onChanged: (bool? value) {
                task.isDone = value ?? false;
                taskController.updateData(task);
              },
            ),
            IconButton(
              icon: Icon(
                Icons.delete,
              ),
              onPressed: () {
                taskController.deleteData(task.id!);
              },
            ),
          ],
        ),
      ),
    );
  }

  Color getColorForPriority(int priority) {
    switch (priority) {
      case 1:
        return Colors.green.shade200;
      case 2:
        return Colors.purple.shade200;
      case 3:
        return Colors.red.shade200;
      default:
        return Colors.grey;
    }
  }
}