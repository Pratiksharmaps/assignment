// import 'package:assignment/provider/task_provider.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';

// class AddTaskScreen extends StatefulWidget {
//   final String userId;

//   AddTaskScreen(this.userId);

//   @override
//   _AddTaskScreenState createState() => _AddTaskScreenState();
// }

// class _AddTaskScreenState extends State<AddTaskScreen> {
//   final _titleController = TextEditingController();
//   final _descriptionController = TextEditingController();
//   DateTime _deadline = DateTime.now();
//   final _durationController = TextEditingController();
//   final _formKey = GlobalKey<FormState>();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Add Task'),
//       ),
//       body: Form(
//         key: _formKey,
//         child: Padding(
//           padding: EdgeInsets.all(16.0),
//           child: Column(
//             children: [
//               TextFormField(
//                 controller: _titleController,
//                 decoration: InputDecoration(labelText: 'Title'),
//                 validator: (value) {
//                   if (value!.isEmpty) {
//                     return 'Please enter a title';
//                   }
//                   return null;
//                 },
//               ),
//               TextFormField(
//                 controller: _descriptionController,
//                 decoration: InputDecoration(labelText: 'Description'),
//                 validator: (value) {
//                   if (value!.isEmpty) {
//                     return 'Please enter a description';
//                   }
//                   return null;
//                 },
//               ),
//               TextFormField(
//                 controller: _durationController,
//                 decoration: InputDecoration(labelText: 'Expected Task Duration (minutes)'),
//                 validator: (value) {
//                   if (value!.isEmpty) {
//                     return 'Please enter the duration';
//                   }
//                   return null;
//                 },
//                 keyboardType: TextInputType.number,
//               ),
//               ElevatedButton(
//                 child: Text('Pick Deadline'),
//                 onPressed: () async {
//                   DateTime? picked = await showDatePicker(
//                     context: context,
//                     initialDate: DateTime.now(),
//                     firstDate: DateTime.now(),
//                     lastDate: DateTime(2101),
//                   );
//                   if (picked != null && picked != _deadline) {
//                     setState(() {
//                       _deadline = picked;
//                     });
//                   }
//                 },
//               ),
//               ElevatedButton(
//                 child: Text('Add Task'),
//                 onPressed: () {
//                   if (_formKey.currentState!.validate()) {
//                     final task = Task(
//                       id: '',
//                       title: _titleController.text,
//                       description: _descriptionController.text,
//                       deadline: _deadline,
//                       duration: int.parse(_durationController.text),
//                       isComplete: false,
//                     );
//                     context.read(taskServiceProvider).addTask(task);
//                     Navigator.pop(context);
//                   }
//                 },
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'package:assignment/provider/task_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AddTaskScreen extends ConsumerStatefulWidget {
  final String userId;

  AddTaskScreen(this.userId);

  @override
  _AddTaskScreenState createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends ConsumerState<AddTaskScreen> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  DateTime _deadline = DateTime.now();
  final _durationController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Task'),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextFormField(
                controller: _titleController,
                decoration: InputDecoration(labelText: 'Title'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a title';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _descriptionController,
                decoration: InputDecoration(labelText: 'Description'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a description';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _durationController,
                decoration: InputDecoration(labelText: 'Expected Task Duration (minutes)'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter the duration';
                  }
                  return null;
                },
                keyboardType: TextInputType.number,
              ),
              ElevatedButton(
                child: Text('Pick Deadline'),
                onPressed: () async {
                  DateTime? picked = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime.now(),
                    lastDate: DateTime(2101),
                  );
                  if (picked != null && picked != _deadline) {
                    setState(() {
                      _deadline = picked;
                    });
                  }
                },
              ),
              ElevatedButton(
                child: Text('Add Task'),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    final task = Task(
                      id: '',
                      title: _titleController.text,
                      description: _descriptionController.text,
                      deadline: _deadline,
                      duration: int.parse(_durationController.text),
                      isComplete: false,
                    );
                    ref.read(taskServiceProvider).addTask(task);
                    Navigator.pop(context);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

