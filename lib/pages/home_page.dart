import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:new_task_app/pages/create_task_page.dart';
import 'package:new_task_app/pages/login_page.dart';
import 'package:new_task_app/pages/update_task_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: SafeArea(
          child: Column(
            children: [
              TextButton(
                  onPressed: () async {
                    FirebaseAuth auth = FirebaseAuth.instance;
                    await auth.signOut();
                    if (context.mounted) {
                      Navigator.of(context).pushReplacement(
                          MaterialPageRoute(builder: (context) => LoginPage()));
                    }
                  },
                  child: Text("Logout")),
            ],
          ),
        ),
      ),
      appBar: AppBar(
        title: Text("Task manager"),
      ),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('users')
              .doc(FirebaseAuth.instance.currentUser!.uid)
              .collection('tasks')
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Text("Errror ${snapshot.error}");
            } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
              return Text("No data found");
            }
            final data = snapshot.data!.docs;

            return ListView.builder(
                itemCount: data.length,
                itemBuilder: (context, index) {
                  final task = data[index];

                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      elevation: 4,
                      color: Colors.grey.shade100,
                      child: ListTile(
                        title: Text(task["title"]),
                        subtitle: Text(task['description']),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                                onPressed: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) =>
                                          UpdateTaskPage(task: task.data())));
                                },
                                icon: Icon(
                                  Icons.edit,
                                  color: Colors.blue,
                                )),
                            IconButton(
                                onPressed: () async {
                                  final firestore = FirebaseFirestore.instance;
                                  await firestore
                                      .collection("users")
                                      .doc(FirebaseAuth
                                          .instance.currentUser!.uid)
                                      .collection('tasks')
                                      .doc(task["id"])
                                      .delete();
                                },
                                icon: Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                )),
                          ],
                        ),
                      ),
                    ),
                  );
                });
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => CreateTaskPage())),
        child: Icon(Icons.add),
      ),
    );
  }
}
