import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const SignUpPage(),
    );
  }
}

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  String nameErrorMessage = '';
  String emailErrorMessage = '';
  String passwordErrorMessage = '';
  String dobErrorMessage = '';
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController dobController = TextEditingController();
  bool done = false;
  void submit(BuildContext context) {
    validateName();
    validateEmail();
    validatePassword();
    validateDOB();
    setState(() {
      if (passwordErrorMessage.isEmpty &&
          dobErrorMessage.isEmpty &&
          emailErrorMessage.isEmpty &&
          nameErrorMessage.isEmpty) {
        done = true;
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => SignInScreen()),
        );
      }
    });
  }

  void validateName() {
    if (nameController.text.isEmpty) {
      setState(() {
        nameErrorMessage = 'Text is Empty!!';
      });
    } else {
      nameErrorMessage = '';
    }
  }

  void validateEmail() {
    if (emailController.text.isEmpty) {
      emailErrorMessage = "Text is empty!!";
    } else if (!correctEmailFormat(emailController.text)) {
      emailErrorMessage = "Not the correct format! name@mail.thing.thing...";
    } else {
      emailErrorMessage = '';
    }
  }

  bool correctEmailFormat(String email) {
    int index = 0;
    String valid = "abcdefghijklmnopqrstuvwxyz1234567890_";
    String delimiter = "@";
    while (index < email.length && email[index] != delimiter) {
      if (!valid.contains(email[index])) {
        return false;
      }
      index += 1;
    }
    index += 1;
    if (index >= email.length) {
      return false;
    }
    valid = "abcdefghijklmnopqrstuvwxyz";
    delimiter = '.';
    while (index < email.length && email[index] != delimiter) {
      if (!valid.contains(email[index])) {
        return false;
      }
      index += 1;
    }
    if (index >= email.length) {
      return false;
    }
    return true;
  }

  void validatePassword() {
    if (passwordController.text.length < 5) {
      setState(() {
        passwordErrorMessage = "Text is too short";
      });
    } else {
      passwordErrorMessage = "";
    }
  }

  void validateDOB() {
    String numbers = "1234567890";
    List<String> indices = [
      numbers,
      numbers,
      "/",
      numbers,
      numbers,
      "/",
      numbers,
      numbers,
      numbers,
      numbers,
    ];
    if (dobController.text.length < indices.length) {
      setState(() {
        dobErrorMessage = "Too short.";
      });
    } else {
      for (var i = 0; i < dobController.text.length; i++) {
        if (!indices[i].contains(dobController.text[i])) {
          setState(() {
            dobErrorMessage = "not right format.";
          });
          return;
        }
      }
      dobErrorMessage = "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            SizedBox(
              width: 300,
              child: TextField(
                controller: nameController,
                decoration: InputDecoration(hintText: "Name"),
              ),
            ),
            if (nameErrorMessage != "") Text(nameErrorMessage),
            SizedBox(
              width: 300,
              child: TextField(
                controller: emailController,
                decoration: InputDecoration(hintText: "Email"),
              ),
            ),
            if (emailErrorMessage != "") Text(emailErrorMessage),
            SizedBox(
              width: 300,
              child: TextField(
                controller: passwordController,
                decoration: InputDecoration(hintText: "Password"),
              ),
            ),
            if (passwordErrorMessage != "") Text(passwordErrorMessage),
            SizedBox(
              width: 300,
              child: TextField(
                controller: dobController,
                decoration: InputDecoration(hintText: "DOB (MM/DD/YYYY)"),
              ),
            ),
            if (dobErrorMessage != "") Text(dobErrorMessage),

            TextButton(onPressed: () => submit(context), child: Text("Submit")),
            if (done) Text("Done."),
          ],
        ),
      ),
    );
  }
}

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Text("Validated. yay")));
  }
}
