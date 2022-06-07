import 'package:cloud_firestore/cloud_firestore.dart';
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
  CollectionReference user = FirebaseFirestore.instance.collection('users');

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
              Padding(
                padding:
                     EdgeInsets.symmetric(horizontal: Dimension.width20, vertical: Dimension.height10),
                child: TextFormField(
                  controller: _nameControler,
                  decoration: InputDecoration(
                      fillColor: Colors.grey.withOpacity(0.5),
                      filled: true,
                      hintText: "enter name",
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(Dimension.height10),
                          borderSide:
                              BorderSide(color: Colors.black, width: Dimension.width2)),
                      // errorBorder: OutlineInputBorder(
                      //     borderRadius: BorderRadius.circular(10),
                      //     borderSide: BorderSide(color: Colors.black, width: 2)),
                      focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(Dimension.height10),
                          borderSide:
                              BorderSide(color: Colors.black, width: Dimension.width2)),
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
                padding:
                     EdgeInsets.symmetric(horizontal: Dimension.width20, vertical: Dimension.height10),
                child: TextFormField(
                  controller: _descriptionControler,
                  decoration: InputDecoration(
                      fillColor: Colors.grey.withOpacity(0.5),
                      filled: true,
                      hintText: "enter description",
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(Dimension.height10),
                          borderSide:
                              BorderSide(color: Colors.black, width: Dimension.width2)),
                      // errorBorder: OutlineInputBorder(
                      //     borderRadius: BorderRadius.circular(10),
                      //     borderSide: BorderSide(color: Colors.black, width: 2)),
                      focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(Dimension.height10),
                          borderSide:
                              BorderSide(color: Colors.black, width: Dimension.width2)),
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
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(primary: Colors.black),
                    child: const Text("save"),
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
                          user
                              .add(userProfile.toMap())
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
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(primary: Colors.black),
                    child: const Text("delete"),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {}
                    },
                  )
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
    await FirebaseFirestore.instance
        .collection('users')
        .get()
        .then((querySnapshot) {
      querySnapshot.docs.forEach((element) {
        if (element['name'] == _nameControler.text) {
          result = true;
        }
      });
    });
    return result;
  }
}
