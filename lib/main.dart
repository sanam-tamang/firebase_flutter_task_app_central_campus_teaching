import 'package:flutter/material.dart';

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
                  "Create an account",
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
