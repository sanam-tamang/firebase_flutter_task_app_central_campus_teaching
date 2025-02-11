// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:new_task_app/snackbar.dart';

class UpdateTaskPage extends StatefulWidget {
  const UpdateTaskPage({
    super.key,
    required this.task,
  });

  final Map<String, dynamic> task;

  @override
  State<UpdateTaskPage> createState() => _UpdateTaskPageState();
}

class _UpdateTaskPageState extends State<UpdateTaskPage> {
  late TextEditingController titleController;
  late TextEditingController descriptionController;

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController(text: widget.task['title']);
    descriptionController =
        TextEditingController(text: widget.task['description']);
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
        title: Text("Updata a task"),
        actions: [
          FilledButton(
              onPressed: () async {
                try {
                  FirebaseFirestore firestore = FirebaseFirestore.instance;
                  await firestore
                      .collection("users")
                      .doc(FirebaseAuth.instance.currentUser!.uid)
                      .collection('tasks')
                      .doc(widget.task['id'])
                      .update({
                    "title": titleController.text,
                    "description": descriptionController.text,
                  });

                  showSnackBar(context, "Updated task");
                } catch (e) {
                  showSnackBar(context, e.toString());
                }

                Navigator.of(context).pop();
              },
              child: Text("Update")),
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
