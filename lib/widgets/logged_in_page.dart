import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:draggable_fab/draggable_fab.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:practice_of_firebase/widgets/user_profile_input_data.dart';

import '../services/search_data.dart';
import 'user_detail_page.dart';

class LoggedInPage extends StatefulWidget {
  const LoggedInPage({Key? key}) : super(key: key);

  @override
  State<LoggedInPage> createState() => _LoggedInPageState();
}

class _LoggedInPageState extends State<LoggedInPage> {
  // final DocumentReference reference =
  //     FirebaseFirestore.instance.collection('easyloadKatha').doc('userProfile');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          //iconTheme: const IconThemeData(color: Colors.black),
          shadowColor: Colors.transparent,
          elevation: 0,
          //backgroundColor: const Color.fromARGB(255, 54, 224, 247),
          backgroundColor: Colors.black,
          title: const Text(
            "Easyload Katha",
          ),
          centerTitle: true,
          actions: [
            IconButton(
                onPressed: () {
                  FirebaseAuth.instance.signOut();
                },
                icon: const Icon(Icons.logout)),
            IconButton(
                onPressed: () {
                  showSearch(context: context, delegate: SearchData());
                },
                icon: const Icon(Icons.search))
          ]),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('users')
            .orderBy('name')
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Text("Somethimg is wrong");
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              return Card(
                color: Colors.grey,
                //color: const Color.fromARGB(255, 85, 201, 247),
                shape: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0)),
                child: ListTile(
                  textColor: Colors.black,
                  iconColor: Colors.black,
                  shape: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0)),
                  leading: const Icon(Icons.book_online_sharp),
                  title: Text(
                    snapshot.data!.docs[index]['name'],
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(snapshot.data!.docs[index]['description']),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              actions: [
                                TextButton(
                                    style: TextButton.styleFrom(
                                        primary: Colors.black),
                                    onPressed: () async {
                                      await FirebaseFirestore.instance
                                          .runTransaction((transaction) async {
                                        transaction.delete(snapshot
                                            .data!.docs[index].reference);
                                      });
                                      Navigator.pop(context);
                                    },
                                    child: const Text("Ok")),
                                TextButton(
                                    style: TextButton.styleFrom(
                                        primary: Colors.black),
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: const Text("Cancel"))
                              ],
                              backgroundColor: Colors.grey,
                              content: const Text(
                                  "Do you want to delete the customer?"),
                              title: const Text("Confirmation"),
                            );
                          });
                    },
                  ),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => UserDetail(
                                  snapshot: snapshot.data!.docs[index],
                                )));
                  },
                ),
              );
            },
            // children: snapshot.data!.docs.map((DocumentSnapshot document) {
            //   Map<String, dynamic> data =
            //       document.data() as Map<String, dynamic>;
            //   return Card(
            //     child: ListTile(
            //       title: Text(data['name']),
            //       subtitle: Text(data['description']),
            //       trailing: IconButton(
            //         icon: const Icon(Icons.delete),
            //         onPressed: (){
            //           data.
            //         },
            //       ),
            //     ),
            //   );
            // }).toList(),
          );
        },
      ),
      // StreamBuilder<DocumentSnapshot>(
      //     stream: FirebaseFirestore.instance
      //         .collection('EasyloadKatha')
      //         .doc('userProfile')
      //         .snapshots(),
      //     builder: (context, snapshot) {
      //       return ListView.builder(
      //         itemBuilder: (context, index) {
      //           return Card(
      //             child: ListTile(
      //               title: Text(snapshot.data![index].name),
      //               subtitle: Text(snapshot.data![index].description),
      //             ),
      //           );
      //         },
      //       );
      //     }),
      floatingActionButton: DraggableFab(
        child: FloatingActionButton.extended(
          backgroundColor: Colors.black.withOpacity(0.8),
          //backgroundColor: const Color.fromARGB(255, 54, 224, 247),
          label: const Text(
            "Add Customer",
          ),
          icon: const Icon(
            Icons.add,
          ),
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (_) => UserProfile()));
          },
        ),
      ),
    );
  }
}
