import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:new_task_app/pages/home_page.dart';
import 'package:new_task_app/pages/login_page.dart';
import 'package:new_task_app/snackbar.dart';

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

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  Future<void> register() async {
    if (emailController.text.trim().isEmpty ||
        passwordController.text.trim().isEmpty) {
      return;
    }
    setState(() {
      isLoading = true;
    });

    try {
      FirebaseAuth auth = FirebaseAuth.instance;

      final userCredentials = await auth.createUserWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text);
      if (mounted) {
        showSnackBar(context, "User Register Successful");
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => HomePage()));
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(e.toString()),
          ),
        );
      }
    } finally {
      setState(() {
        isLoading = false;
      });
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
            child: Center(
              child: Card(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 40),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "Create an account",
                        style: TextStyle(
                            fontSize: 36,
                            fontWeight: FontWeight.w600,
                            color: Colors.indigo),
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
                          child: FilledButton(
                              onPressed: isLoading ? null : register,
                              child: isLoading
                                  ? CircularProgressIndicator()
                                  : Text("Register"))),
                      SizedBox(height: 12),
                      TextButton(
                          onPressed: () => Navigator.of(context)
                              .pushReplacement(MaterialPageRoute(
                                  builder: (context) => LoginPage())),
                          child: RichText(
                              text: TextSpan(children: [
                            TextSpan(text: "Already have an account? "),
                            TextSpan(
                                text: "Login",
                                style: TextStyle(color: Colors.blue)),
                          ])))
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
