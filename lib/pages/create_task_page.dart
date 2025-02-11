import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:new_task_app/snackbar.dart';

class CreateTaskPage extends StatefulWidget {
  const CreateTaskPage({super.key});

  @override
  State<CreateTaskPage> createState() => _CreateTaskPageState();
}

class _CreateTaskPageState extends State<CreateTaskPage> {
  late TextEditingController titleController;
  late TextEditingController descriptionController;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController();
    descriptionController = TextEditingController();
  }

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  Future<void> createTask() async {
    if (titleController.text.isEmpty || descriptionController.text.isEmpty) {
      showSnackBar(context, "Title and Description cannot be empty");
      return;
    }

    setState(() {
      isLoading = true;
    });

    try {
      final id = DateTime.now().toString();
      FirebaseFirestore firestore = FirebaseFirestore.instance;
      await firestore
          .collection("users")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('tasks')
          .doc(id)
          .set({
        "id": id,
        "title": titleController.text,
        "description": descriptionController.text,
      });

      showSnackBar(context, "Task added successfully");
      Navigator.of(context).pop();
    } catch (e) {
      showSnackBar(context, "Error: ${e.toString()}");
    }

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Create a task"),
        actions: [
          isLoading
              ? Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: CircularProgressIndicator(),
                )
              : FilledButton(
                  onPressed: createTask,
                  child: Text("Post"),
                ),
          SizedBox(width: 12),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(8),
        children: [
          TextField(
            maxLines: null,
            maxLength: 40,
            controller: titleController,
            decoration:
                InputDecoration(hintText: "Title", border: InputBorder.none),
          ),
          SizedBox(height: 20),
          TextField(
            maxLines: null,
            controller: descriptionController,
            decoration: InputDecoration(
                hintText: "Description", border: InputBorder.none),
          ),
        ],
      ),
    );
  }
}
