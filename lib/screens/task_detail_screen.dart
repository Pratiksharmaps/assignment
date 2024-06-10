import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TaskDetailScreen extends StatefulWidget {
  final String? taskId;

  TaskDetailScreen({this.taskId});

  @override
  _TaskDetailScreenState createState() => _TaskDetailScreenState();
}

class _TaskDetailScreenState extends State<TaskDetailScreen> {
  final _formKey = GlobalKey<FormState>();
  String _title = '';
  String _description = '';
  DateTime _deadline = DateTime.now();
  Duration _duration = Duration(hours: 1);

  void _submitTask() async {
    if (!_formKey.currentState!.validate()) return;
    _formKey.currentState!.save();

    final tasks = FirebaseFirestore.instance.collection('tasks');

    if (widget.taskId == null) {
      await tasks.add({
        'title': _title,
        'description': _description,
        'deadline': _deadline,
        'duration': _duration.inMinutes,
        'completed': false,
      });
    } else {
      await tasks.doc(widget.taskId).update({
        'title': _title,
        'description': _description,
        'deadline': _deadline,
        'duration': _duration.inMinutes,
      });
    }

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.taskId == null ? 'New Task' : 'Edit Task'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Title'),
                onSaved: (value) {
                  _title = value!;
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a title';
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Description'),
                onSaved: (value) {
                  _description = value!;
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a description';
                  }
                  return null;
                },
              ),
              // Date and time picker for deadline
              ElevatedButton(
                onPressed: _submitTask,
                child: Text('Save Task'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
