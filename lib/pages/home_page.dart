import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:new_task_app/pages/create_task_page.dart';
import 'package:new_task_app/pages/login_page.dart';

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
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => CreateTaskPage())),
        child: Icon(Icons.add),
      ),
    );
  }
}
