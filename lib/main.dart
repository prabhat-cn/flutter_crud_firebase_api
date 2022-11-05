import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_crud_firebase_api/screens/homePage.dart';

void main() {
  // firebase need first
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

// Check firebase
// Future main() async {
//   WidgetsFlutterBinding.ensureInitialized();

//   await Firebase.initializeApp();

//   runApp(const MyApp());
// }

class MyApp extends StatelessWidget {
  MyApp({super.key});
  // firebase
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initialization,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          print("Somrthing went wrong!");
        }
        // Once completed, show application
        if (snapshot.connectionState == ConnectionState.done) {
          return MaterialApp(
            title: 'Flutter Firebase-Store CRUD',
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            debugShowCheckedModeBanner: false,
            home: const HomePage(),
          );
        }
        return CircularProgressIndicator();
      },
    );
  }
}
