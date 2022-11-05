import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_crud_firebase_api/screens/updateStudent.dart';

// use "StreamBuilder" to show instant change

class ListStudent extends StatefulWidget {
  const ListStudent({Key? key}) : super(key: key);

  @override
  _ListStudentState createState() => _ListStudentState();
}

class _ListStudentState extends State<ListStudent> {
  final Stream<QuerySnapshot> studentsStream =
      FirebaseFirestore.instance.collection('students').snapshots();

  int count = 5;

  // _deleteUser(id) {
  //   print("Student Deleted Id--> $id");
  // }
  // For Deleting User
  CollectionReference students =
      FirebaseFirestore.instance.collection('students');
  // "Future<void>"-> return type void
  Future<void> _deleteUser(id) {
    // print("User Deleted $id");
    return students
        .doc(id)
        .delete()
        .then((value) => {
              print('User Deleted'),
            })
        .catchError((error) => print('Failed to Delete user: $error'));
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: studentsStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            print("Something went wrong!");
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          // to get list of data
          final List storedocs = [];

          // get data from docs
          // snapshot.data! --- is not null
          // If type is different "dynamic"
          // ".toList()"- need otherwise blank data show
          snapshot.data!.docs.reversed.map((DocumentSnapshot document) {
            Map sData = document.data() as Map<String, dynamic>;
            storedocs.add(sData);

            // to get id
            print(document.id);
            // add id
            sData['id'] = document.id;
          }).toList();

          return Container(
            margin:
                const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Table(
                border: TableBorder.all(),
                columnWidths: const <int, TableColumnWidth>{
                  1: FixedColumnWidth(140),
                },
                defaultVerticalAlignment: TableCellVerticalAlignment.middle,

                // Start
                children: [
                  TableRow(children: [
                    // THead
                    // One
                    TableCell(
                      child: Container(
                        color: Colors.greenAccent,
                        child: const Center(
                          child: Text(
                            'Name',
                            style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                    // Two
                    TableCell(
                      child: Container(
                        color: Colors.greenAccent,
                        child: const Center(
                          child: Text(
                            'Name',
                            style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                    // Three
                    TableCell(
                      child: Container(
                        color: Colors.greenAccent,
                        child: const Center(
                          child: Text(
                            'Name',
                            style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),

                    // const Text("Institution name", textScaleFactor: 1.5),
                    // const Text("University", textScaleFactor: 1.5),
                  ]),
                  // TBody

                  // for (var i = 0; i < count; i++) ...[
                  for (var i = 0; i < storedocs.length; i++) ...[
                    TableRow(children: [
                      TableCell(
                        child: Center(
                          child: Text(
                            storedocs[i]['name'],
                            style: TextStyle(fontSize: 15),
                          ),
                        ),
                      ),
                      TableCell(
                        child: Center(
                          child: Text(
                            storedocs[i]['email'],
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                      ),
                      TableCell(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                              onPressed: () => {
                                print('Edit Press'),
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>

                                        // Page name
                                        UpdateStudent(
                                            stuId: storedocs[i]['id']),
                                  ),
                                )
                                // Navigator.push(
                                //   context,
                                //   MaterialPageRoute(
                                //     builder: (context) =>
                                //         UpdateStudentPage(id: storedocs[i]['id']),
                                //   ),
                                // )
                              },
                              icon: const Icon(
                                Icons.edit,
                                color: Colors.orange,
                              ),
                            ),
                            IconButton(
                              onPressed: () => {
                                // _deleteUser(1),
                                _deleteUser(storedocs[i]['id']),
                              },
                              icon: const Icon(
                                Icons.delete,
                                color: Colors.red,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ]),
                  ]

                  // const TableRow(children: [
                  //   Text("12th", textScaleFactor: 1.5),
                  //   Text("Delhi Public School", textScaleFactor: 1.5),
                  //   Text("CBSE", textScaleFactor: 1.5),
                  // ]),
                ],

                // End
              ),
            ),
          );
        });
  }
}
