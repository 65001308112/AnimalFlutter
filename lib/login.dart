import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'registration.dart';
import 'main.dart';

class Login extends StatefulWidget {
  final Function(String) onTitleChange;

  const Login({super.key, required this.onTitleChange});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _login() async {
    String email = _emailController.text;
    String password = _passwordController.text;

    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      _showSuccess('Login successful!');
      _navigateToMain();
    } catch (e) {
      _showError('Login failed: ${e.toString()}');
    }
  }

  void _navigateToMain() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const MyApp()),
    ).then((_) {
      widget.onTitleChange('Login');
    });
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  void _showSuccess(String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  void _navigateToRegistration() {
    widget.onTitleChange('Registration');
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Registration(
          onTitleChange: widget.onTitleChange,
        ),
      ),
    ).then((_) {
      widget.onTitleChange('Login');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Login Form'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                ElevatedButton(
                  onPressed: _login,
                  child: const Text('Login'),
                ),
                ElevatedButton(
                  onPressed: _navigateToRegistration,
                  child: const Text('No account? Register here.'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
