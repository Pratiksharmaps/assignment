import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Task {
  String id;
  String title;
  String description;
  DateTime deadline;
  int duration;
  bool isComplete;

  Task({
    required this.id,
    required this.title,
    required this.description,
    required this.deadline,
    required this.duration,
    required this.isComplete,
  });

  factory Task.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map;
    return Task(
      id: doc.id,
      title: data['title'] ?? '',
      description: data['description'] ?? '',
      deadline: (data['deadline'] as Timestamp).toDate(),
      duration: data['duration'] ?? 0,
      isComplete: data['isComplete'] ?? false,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'deadline': deadline,
      'duration': duration,
      'isComplete': isComplete,
    };
  }
}

class TaskService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Stream<List<Task>> getTasks(String userId) {
    return _db.collection('tasks')
        .where('userId', isEqualTo: userId)
        .snapshots()
        .map((snapshot) => snapshot.docs
        .map((doc) => Task.fromFirestore(doc))
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

final taskServiceProvider = Provider<TaskService>((ref) {
  return TaskService();
});

final taskListProvider = StreamProvider.family<List<Task>, String>((ref, userId) {
  return ref.watch(taskServiceProvider).getTasks(userId);
});
