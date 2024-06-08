
// // import 'package:uuid/uuid.dart';
// // class Task  {
// //   Task(
// //       {required this.id,
// //       required this.title,
// //       required this.subtitle,
// //       required this.createdAtTime,
// //       required this.createdAtDate,
// //       required this.isCompleted});

// //   final String id;
// //   String title;
// //   String subtitle;
// //   DateTime createdAtTime;
// //   DateTime createdAtDate;
// //   bool isCompleted;

// //   factory Task.create({
// //     required String? title,
// //     required String? subtitle,
// //     DateTime? createdAtTime,
// //     DateTime? createdAtDate,
// //   }) =>
// //       Task(
// //         id: const Uuid().v1(),
// //         title: title ?? "",
// //         subtitle: subtitle ?? "",
// //         createdAtTime: createdAtTime ?? DateTime.now(),
// //         isCompleted: false,
// //         createdAtDate: createdAtDate ?? DateTime.now(),
// //       );
// // }
// class Task {
//   final String id;
//   final String title;
//   final String description;
//   final DateTime deadline;
//   final int duration;
//   final bool isComplete;

//   Task({
//     required this.id,
//     required this.title,
//     required this.description,
//     required this.deadline,
//     required this.duration,
//     required this.isComplete,
//   });

//   factory Task.fromFirestore(DocumentSnapshot doc) {
//     Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
//     return Task(
//       id: doc.id,
//       title: data['title'],
//       description: data['description'],
//       deadline: (data['deadline'] as Timestamp).toDate(),
//       duration: data['duration'],
//       isComplete: data['isComplete'],
//     );
//   }

//   Map<String, dynamic> toFirestore() {
//     return {
//       'title': title,
//       'description': description,
//       'deadline': deadline,
//       'duration': duration,
//       'isComplete': isComplete,
//     };
//   }
// }
