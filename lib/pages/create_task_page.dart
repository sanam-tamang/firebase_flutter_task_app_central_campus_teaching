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

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController();
    descriptionController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();

    titleController.dispose();
    descriptionController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Create a task"),
        actions: [
          FilledButton(
              onPressed: () async {
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

                  showSnackBar(context, "Task added");
                } catch (e) {
                  showSnackBar(context, e.toString());
                }

                Navigator.of(context).pop();
              },
              child: Text("Post")),
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
