import 'package:cloud_firestore/cloud_firestore.dart';

class TaskService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Stream<List<Task>> getTasks(String userId) {
    return _db.collection('tasks')
        .where('userId', isEqualTo: userId)
        .snapshots()
        .map((snapshot) => snapshot.docs
        .map((doc) => Task.fromFirestore(doc.data()))
        .toList());
  }

  Future<void> addTask(Task task) {
    return _db.collection('tasks').add(task.toMap());
  }

  Future<void> updateTask(Task task) {
    return _db.collection('tasks').doc(task.id).update(task.toMap());
  }

  Future<void> deleteTask(String taskId) {
    return _db.collection('tasks').doc(taskId).delete();
  }
}

class Task {
  String id;
  String title;
  String description;
  DateTime deadline;
  int duration;
  bool isComplete;

  Task({required this.id, required this.title, required this.description, required this.deadline, required this.duration, required this.isComplete});

  factory Task.fromFirestore(Map<String, dynamic> data) {
    return Task(
      id: data['id'],
      title: data['title'],
      description: data['description'],
      deadline: (data['deadline'] as Timestamp).toDate(),
      duration: data['duration'],
      isComplete: data['isComplete'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'deadline': deadline,
      'duration': duration,
      'isComplete': isComplete,
    };
  }
}
