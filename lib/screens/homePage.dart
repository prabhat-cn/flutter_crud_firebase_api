import 'package:flutter/material.dart';
import 'package:flutter_crud_firebase_api/screens/addStudent.dart';
import 'package:flutter_crud_firebase_api/screens/listStudent.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    // return Container(
    //   child: const Text("This is home page!"),
    // );
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('Flutter FireStore CRUD'),
            ElevatedButton(
              onPressed: () => {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AddStudent(),
                  ),
                )
              },
              style:
                  ElevatedButton.styleFrom(backgroundColor: Colors.deepPurple),
              child: const Text('Add', style: TextStyle(fontSize: 20.0)),
            )
          ],
        ),
      ),
      // body: const ListStudent(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: const [
          Text(
            'Student List',
            style: TextStyle(
              fontSize: 25.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          ListStudent(),
        ],
      ),
    );
  }
}
