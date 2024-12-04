import 'package:cloud_firestore/cloud_firestore.dart';

class TaskInstance {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Add a new task to Firestore
  Future<void> addProduct(Map<String, dynamic> taskList) async {
    taskList['isDone'] = false;
    taskList['timestamp'] = FieldValue.serverTimestamp();

    try {
      await _firestore.collection('Users').add(taskList);
    } catch (e) {
      throw Exception("Error adding task: $e");
    }
  }

  // Remove the task from Firestore
  Future<void> removeProduct(String id) async {
    try {
      await _firestore.collection('Users').doc(id).delete();
    } catch (e) {
      throw Exception("Error deleting task: $e");
    }
  }

  // To toggle the 'isDone' status of a task
  Future<void> toggleTaskStatus(String id, bool isDone) async {
    try {
      await _firestore.collection('Users').doc(id).update({
        'isDone': !isDone, // Toggle the 'isDone' status
      });
    } catch (e) {
      throw Exception("Error toggling task status: $e");
    }
  }
}
