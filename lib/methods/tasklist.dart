import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:testingapp/firebaseinstance.dart';
import 'package:testingapp/methods/taskform.dart';

class Tasklist extends StatelessWidget {
  const Tasklist({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('Users')
          .orderBy('timestamp', descending: true)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return const Center(
            child: Text(
              "No Task Found",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          );
        }
        final taskList = snapshot.data!.docs;
        return ListView.builder(
          itemCount: taskList.length,
          itemBuilder: (context, index) {
            final taskItem = taskList[index];
            final taskData = taskItem.data() as Map<String, dynamic>;
            final title = taskData['title'] ?? 'No Title';
            final description = taskData['description'] ?? 'No Description';
            final isDone = taskData['isDone'] ?? false;
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 13),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.lightBlue[50],
                  // Border color and width
                  borderRadius: BorderRadius.circular(10), // Rounded corners
                ),
                child: ListTile(
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  title: Text(
                    title,
                    style: TextStyle(fontSize: 20),
                  ),
                  // subtitle: Text(description),
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      shape: const RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(20)),
                      ),
                      builder: (BuildContext context) {
                        return AddTaskForm(
                          taskId: taskItem.id,
                          titleEditor: title,
                          descriptionEditor: description,
                        );
                      },
                    );
                  },
                  tileColor: Colors.white,
                  leading: IconButton(
                    onPressed: () async {
                      try {
                        await TaskInstance().toggleTaskStatus(
                            taskItem.id, taskData['isDone'] ?? false);
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("Error: ${e.toString()}")),
                        );
                      }
                    },
                    icon: Icon(
                      isDone ? Icons.check_box : Icons.check_box_outline_blank,
                      color: Colors.blue,
                    ),
                  ),
                  trailing: IconButton(
                    onPressed: () async {
                      try {
                        await TaskInstance().removeProduct(taskItem.id);
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Task deleted '),
                          ),
                        );
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("Error: ${e.toString()}")),
                        );
                      }
                    },
                    icon: const Icon(
                      Icons.delete,
                      color: Colors.red,
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
