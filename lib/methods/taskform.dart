import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:testingapp/firebaseinstance.dart';

class AddTaskForm extends StatefulWidget {
  final String? titleEditor;
  final String? descriptionEditor;
  final String? taskId;

  const AddTaskForm({
    this.titleEditor,
    this.descriptionEditor,
    this.taskId,
    super.key,
  });

  static void showAddTaskForm(
    BuildContext context, {
    String? title,
    String? description,
  }) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        return AddTaskForm(
          titleEditor: title,
          descriptionEditor: description,
        );
      },
    );
  }

  @override
  State<AddTaskForm> createState() => _AddTaskFormState();
}

class _AddTaskFormState extends State<AddTaskForm> {
  late TextEditingController titleController;
  late TextEditingController descriptionController;
  final TaskInstance _taskInstance = TaskInstance();

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController(text: widget.titleEditor ?? '');
    descriptionController =
        TextEditingController(text: widget.descriptionEditor ?? '');
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: 10,
        left: 16,
        right: 16,
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: SingleChildScrollView(
        child: SizedBox(
          height: 230,
          child: Column(
            children: [
              const Text(
                "Enter your Task",
                style: TextStyle(fontSize: 20),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: titleController,
                decoration: const InputDecoration(
                  hintText: 'Task Title',
                  hintStyle: TextStyle(fontSize: 20),
                ),
                style: const TextStyle(fontSize: 20),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: descriptionController,
                decoration: const InputDecoration(
                  hintText: 'Task Description',
                ),
              ),
              const SizedBox(height: 15),
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                onPressed: () async {
                  if (titleController.text.isEmpty &&
                      descriptionController.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Please enter the Task")),
                    );
                  } else {
                    try {
                      if (widget.taskId != null) {
                        // Updates existing task
                        await FirebaseFirestore.instance
                            .collection('Users')
                            .doc(widget.taskId)
                            .update({
                          'title': titleController.text,
                          'description': descriptionController.text,
                        });
                      } else {
                        // Add new task
                        await _taskInstance.addProduct({
                          'title': titleController.text,
                          'description': descriptionController.text,
                        });
                      }
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text(widget.taskId != null
                            ? "Task updated successfully!"
                            : "Task added successfully!"),
                      ));

                      // Clear the form fields
                      titleController.clear();
                      descriptionController.clear();

                      Navigator.of(context).pop();
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Error: ${e.toString()}")),
                      );
                    }
                  }
                },
                child: const Text(
                  "Add Task",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
