import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:practice_of_firebase/models/user_profile_data.dart';

import '../services/dimension.dart';

class UserProfile extends StatelessWidget {
  UserProfile({Key? key}) : super(key: key);
  //final void Function(String name, String description) callback;
  final _formKey = GlobalKey<FormState>();

  final _nameControler = TextEditingController();

  final _descriptionControler = TextEditingController();
  // final DocumentReference reference =
  //     FirebaseFirestore.instance.doc('EasyloadKatha/userProfile');
  //CollectionReference user = FirebaseFirestore.instance.collection('users');
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("user profile"),
          backgroundColor: Colors.black,
          elevation: 0,
        ),
        body: Form(
            key: _formKey,
            child:
                Column(mainAxisAlignment: MainAxisAlignment.start, children: [
              SizedBox(
                height: Dimension.height30,
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: Dimension.width20,
                    vertical: Dimension.height10),
                child: TextFormField(
                  cursorColor: Colors.black,
                  controller: _nameControler,
                  decoration: InputDecoration(
                      fillColor: Colors.grey.withOpacity(0.5),
                      filled: true,
                      hintText: "enter name",
                      focusedBorder: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.circular(Dimension.height10),
                          borderSide: BorderSide(
                              color: Colors.black, width: Dimension.width2)),
                      // errorBorder: OutlineInputBorder(
                      //     borderRadius: BorderRadius.circular(10),
                      //     borderSide: BorderSide(color: Colors.black, width: 2)),
                      focusedErrorBorder: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.circular(Dimension.height10),
                          borderSide: BorderSide(
                              color: Colors.black, width: Dimension.width2)),
                      enabledBorder: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.circular(Dimension.height10),
                          borderSide: BorderSide(
                              color: Colors.black, width: Dimension.width2))),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "name is required";
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: Dimension.width20,
                    vertical: Dimension.height10),
                child: TextFormField(
                  cursorColor: Colors.black,
                  controller: _descriptionControler,
                  decoration: InputDecoration(
                      fillColor: Colors.grey.withOpacity(0.5),
                      filled: true,
                      hintText: "enter description",
                      focusedBorder: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.circular(Dimension.height10),
                          borderSide: BorderSide(
                              color: Colors.black, width: Dimension.width2)),
                      // errorBorder: OutlineInputBorder(
                      //     borderRadius: BorderRadius.circular(10),
                      //     borderSide: BorderSide(color: Colors.black, width: 2)),
                      focusedErrorBorder: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.circular(Dimension.height10),
                          borderSide: BorderSide(
                              color: Colors.black, width: Dimension.width2)),
                      enabledBorder: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.circular(Dimension.height10),
                          borderSide: BorderSide(
                              color: Colors.black, width: Dimension.width2))),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "description is required";
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // SizedBox(
                  //   width: Dimension.width20,
                  // ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: Colors.black,
                        fixedSize: Size(Dimension.width70, Dimension.height35)),
                    child: Text(
                      "save",
                      style: TextStyle(fontSize: Dimension.height16),
                    ),
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        var userProfile = UserProfileData(
                            name: _nameControler.text,
                            description: _descriptionControler.text,
                            advance: 0,
                            total: 0);
                        var result = await checkUserName();
                        if (result) {
                          _showSnackBar(context, "user already exist");
                        } else {
                          final id = firebaseAuth.currentUser!.uid;

                          CollectionReference user =
                              FirebaseFirestore.instance.collection(id);
                          user
                              .doc().set(userProfile.toMap())
                              .then((value) =>
                                  _showSnackBar(context, "User added"))
                              .catchError(
                                  (e) => _showSnackBar(context, e.toString()));
                        }
                        // CollectionReference reference =
                        //     FirebaseFirestore.instance.collection('users');
                        // QuerySnapshot querySnapshot = await reference.get();
                        // final allData = querySnapshot.docs.map((doc) {
                        //   return doc.data();
                        // }).toList();
                        // if (allData.contains(_nameControler.text)) {
                        //   _showSnackBar(context, "user is already present");
                        // }
                        // StreamSubscription<DocumentSnapshot> subscription;
                        // var reference = FirebaseFirestore.instance
                        //     .collection('users')
                        //     .doc();
                        // subscription = reference.snapshots().listen((event) {
                        //   if (event
                        //       .data()!
                        //       .containsValue(_nameControler.text)) {
                        //     _showSnackBar(context, 'user already exist');
                        //   } else {}
                        // });

                        _nameControler.clear();
                        _descriptionControler.clear();

                        // user
                        //     .set(userProfile.toMap())
                        //     .catchError((e) => print(e));
                        //Navigator.pop(context);
                      }
                    },
                  ),
                  // SizedBox(
                  //   width: Dimension.width20,
                  // ),
                  // Expanded(
                  //   child: ElevatedButton(
                  //     style: ElevatedButton.styleFrom(
                  //         primary: Colors.black,
                  //         fixedSize:
                  //             Size(Dimension.width70, Dimension.height35)),
                  //     child: Text(
                  //       "delete",
                  //       style: TextStyle(fontSize: Dimension.height16),
                  //     ),
                  //     onPressed: () {
                  //       if (_formKey.currentState!.validate()) {
                  //         showDialog(
                  //             context: context,
                  //             builder: (context) {
                  //               return const AlertDialog(
                  //                 title: Text("Inform"),
                  //                 content: Text(
                  //                     "This feature will be available soon"),
                  //               );
                  //             });
                  //       }
                  //     },
                  //   ),
                  // ),
                  // SizedBox(
                  //   width: Dimension.width20,
                  // ),
                ],
              )
            ])));
  }

  _showSnackBar(BuildContext context, String message) {
    var snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  Future<bool> checkUserName() async {
    bool result = false;
    final collectionId = FirebaseAuth.instance.currentUser!.uid;
    await FirebaseFirestore.instance
        .collection(collectionId)
        .get()
        .then((querySnapshot) {
      for (var element in querySnapshot.docs) {
        if (element['name'] == _nameControler.text) {
          result = true;
        }
      }
    });
    return result;
  }
}
