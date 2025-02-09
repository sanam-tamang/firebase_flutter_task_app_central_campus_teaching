import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:new_task_app/snackbar.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Task app',
        home: RegisterPage());
  }
}

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool isPasswordHidden = true;
  bool isLoading = false;

  late TextEditingController emailController;
  late TextEditingController passwordController;

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
    passwordController = TextEditingController();
  }

  Future<void> register() async {
    setState(() {
      isLoading = true;
    });
    try {
      FirebaseAuth auth = FirebaseAuth.instance;

      final userCrediatials = await auth.createUserWithEmailAndPassword(
          email: emailController.text, password: passwordController.text);

      if (mounted) {
        showSnackBar(context, "User register successful");
      }
    } on FirebaseAuthException catch (e) {
      if (mounted) {
        showSnackBar(context, e.message ?? "Errro registering user");
      }
    } finally {
      
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.maxFinite,
        width: double.maxFinite,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(
                  'assets/images/bg_image.png',
                ),
                fit: BoxFit.cover)),
        child: Container(
          decoration: BoxDecoration(
              color: const Color.fromARGB(95, 4, 0, 0).withAlpha(155)),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Register",
                  style: TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.w600,
                      color: Colors.white),
                ),
                SizedBox(height: 32),
                Container(
                  height: 55,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(19)),
                  child: TextField(
                    controller: emailController,
                    decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.email,
                        ),
                        labelText: "Email",
                        hintText: "Enter your email",
                        border: InputBorder.none),
                  ),
                ),
                SizedBox(height: 24),
                Container(
                  height: 55,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(19)),
                  child: TextField(
                    controller: passwordController,
                    obscureText: isPasswordHidden,
                    decoration: InputDecoration(
                        prefixIcon: Icon(Icons.password),
                        labelText: "Password",
                        hintText: "Enter your password",
                        border: InputBorder.none,
                        suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                isPasswordHidden = !isPasswordHidden;
                              });
                            },
                            icon: Icon(isPasswordHidden
                                ? Icons.visibility_off
                                : Icons.visibility))),
                  ),
                ),
                SizedBox(height: 36),
                SizedBox(
                    width: double.maxFinite,
                    height: 40,
                    child:
                        FilledButton(onPressed: () {}, child: Text("Register")))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
