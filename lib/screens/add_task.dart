import 'package:assignment/components/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:assignment/provider/task_provider.dart';
import 'package:assignment/services/notification_service.dart';

class AddTaskScreen extends ConsumerStatefulWidget {
  final Task? task;
  final String userid;

  const AddTaskScreen(this.userid, {Key? key, this.task}) : super(key: key);

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
  void initState() {
    super.initState();
    if (widget.task != null) {
      _titleController.text = widget.task!.title;
      _descriptionController.text = widget.task!.description;
      _deadline = widget.task!.deadline;
      _durationController.text = widget.task!.duration.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    final notificationService = ref.read(notificationServiceProvider);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: secondaryColor,
        title: const Text('Add Task'),
        titleTextStyle: const TextStyle(color: Colors.white, fontSize: 24),
        foregroundColor: Colors.white,
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  controller: _titleController,
                  decoration: const InputDecoration(labelText: 'Title'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter a title';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _descriptionController,
                  decoration: const InputDecoration(labelText: 'Description'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter a description';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _durationController,
                  decoration: const InputDecoration(
                      labelText: 'Expected Task Duration (minutes)'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter the duration';
                    }
                    return null;
                  },
                  keyboardType: TextInputType.number,
                ),
                const Padding(padding: EdgeInsets.symmetric(vertical: 10)),
                const Text(
                  'Deadline',
                  style: TextStyle(fontSize: 17),
                ),
                Row(
                  children: [
                    Expanded(
                        child:
                            Text(DateFormat.yMd().add_jm().format(_deadline))),
                    Expanded(
                      child: IconButton(
                        alignment: Alignment.centerRight,
                        icon: const Icon(Icons.calendar_today),
                        onPressed: () async {
                          final selectedDate = await showDatePicker(
                            context: context,
                            initialDate: _deadline,
                            firstDate: DateTime(2000),
                            lastDate: DateTime(2101),
                          );
                          if (selectedDate != null) {
                            final selectedTime = await showTimePicker(
                              context: context,
                              initialTime: TimeOfDay.fromDateTime(_deadline),
                            );
                            if (selectedTime != null) {
                              setState(() {
                                _deadline = DateTime(
                                  selectedDate.year,
                                  selectedDate.month,
                                  selectedDate.day,
                                  selectedTime.hour,
                                  selectedTime.minute,
                                );
                              });
                            }
                          }
                        },
                      ),
                    ),
                  ],
                ),
                const Padding(padding: EdgeInsets.symmetric(vertical: 20)),
                Center(
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: primaryColor,
                        elevation: 5,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 40, vertical: 13),
                      ),
                      child: const Text(
                        'Add Task',
                        style: TextStyle(color: Colors.white, fontSize: 15),
                      ),
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          final task = Task(
                            id: widget.task?.id ?? '',
                            title: _titleController.text,
                            description: _descriptionController.text,
                            deadline: _deadline,
                            duration: int.parse(_durationController.text),
                            isComplete: widget.task?.isComplete ?? false,
                          );
                          if (widget.task == null) {
                            final isGranted =
                                await _checkNotificationPermission();
                            if (isGranted) {
                              await ref
                                  .read(taskServiceProvider)
                                  .addTask(task, widget.userid);

                              notificationService.scheduleNotification(
                                _deadline,
                                'Task Reminder',
                                'Your task "${_titleController.text}" is due in 10 minutes',
                              );
                            } else {
                              await _requestNotificationPermissions();
                            }
                          }
                          Navigator.pop(context);
                        }
                      }
                      ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<bool> _checkNotificationPermission() async {
    final AndroidFlutterLocalNotificationsPlugin? androidImplementation =
        flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>();
    if (androidImplementation != null) {
      return await androidImplementation.areNotificationsEnabled() ?? false;
    }
    return false;
  }

  Future<void> _requestNotificationPermissions() async {
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.requestNotificationsPermission();
  }
}
