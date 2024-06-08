import 'package:assignment/provider/auth_provider.dart';
import 'package:assignment/provider/task_provider.dart';
import 'package:assignment/screens/add_task.dart';
import 'package:assignment/screens/signin.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TaskScreen extends ConsumerWidget {
  const TaskScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authStateProvider);

    return authState.when(
      data: (user) {
        if (user == null) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const signIn()),
            );
          });
          return const Center(child: CircularProgressIndicator());
        }

        final taskList = ref.watch(taskListProvider(user.uid));
        return Scaffold(
          appBar: AppBar(
            title: const Text('Your Tasks'),
            actions: [
              IconButton(
                icon: const Icon(Icons.logout),
                onPressed: () async {
                  await FirebaseAuth.instance.signOut();
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) =>const signIn()),
                  );
                },
              ),
            ],
          ),
          body: taskList.when(
            data: (tasks) {
              return ListView.builder(
                itemCount: tasks.length,
                itemBuilder: (context, index) {
                  final task = tasks[index];
                  return ListTile(
                    tileColor: Colors.blue[50],
                    title: Text(task.title),
                    subtitle: Text(task.description),
                    trailing: Checkbox(
                      value: task.isComplete,
                      onChanged: (value) {
                        task.isComplete = value!;
                        ref.read(taskServiceProvider).updateTask(task);
                      },
                    ),
                  );
                },
              );
            },
            loading: () => const Center(child:  CircularProgressIndicator()),
            error: (e, _) => Center(child: Text('Error: $e')),
          ),
          floatingActionButton: FloatingActionButton(
            child: const Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AddTaskScreen(user.uid)),
              );
            },
          ),
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, _) => Center(child: Text('Error: $e')),
    );
  }
}
