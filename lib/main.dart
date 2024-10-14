import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'registration.dart'; 
import 'login.dart';
import 'package:firebase_database/firebase_database.dart';
import 'animals.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _appTitle = 'Animal Flutter';

  void _updateTitle(String title) {
    setState(() {
      _appTitle = title;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _appTitle,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.greenAccent),
        useMaterial3: true,
      ),
      home: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasData) {
            return HomePage(onTitleChange: _updateTitle, appTitle: _appTitle);
          } else {
            return Login(onTitleChange: _updateTitle);
          }
        },
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  final Function(String) onTitleChange;
  final String appTitle;

  const HomePage({super.key, required this.onTitleChange, required this.appTitle});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _username = '';

  @override
  void initState() {
    super.initState();
    _fetchUsername();
  }

  void _fetchUsername() async {
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      final databaseReference = FirebaseDatabase.instance.ref('users/${user.uid}');
      DatabaseEvent event = await databaseReference.once();

      // Access the DataSnapshot from the DatabaseEvent
      final DataSnapshot snapshot = event.snapshot;

      if (snapshot.exists) {
        setState(() {
          _username = snapshot.child('username').value.toString();
        });
      }
    }
  }

  void toAnimals() {
    widget.onTitleChange('Animals');
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AnimalList(onTitleChange: widget.onTitleChange),
      ),
    ).then((_) {
      widget.onTitleChange(widget.appTitle);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.appTitle),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            if (_username.isNotEmpty)
              Text(
                'Welcome, $_username!',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(fontSize: 24), // Increase font size
              ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: toAnimals,
              child: const Text('Go to Animals'),
            ),
          ],
        ),
      ),
      
    );
  }
}
