import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:practice_of_firebase/services/dimension.dart';
import 'package:practice_of_firebase/services/emial_password_authentication.dart';
import 'package:provider/provider.dart';

import 'services/google_authentication.dart';
import 'widgets/home.dart';
import 'widgets/logged_in_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //initialize as a firebase app
  await Firebase.initializeApp();
  //store data locally when offline by default its true
  // FirebaseFirestore.instance.settings =
  //     const Settings(persistenceEnabled: false);
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);
  //var provider = EmailAndPassword();

  @override
  Widget build(BuildContext context) {
    // print(Dimension.screenHeight);
    // print(Dimension.screenWidth);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => EmailAndPassword()),
        ChangeNotifierProvider(create: (context) => Google())
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          home: Scaffold(
            // appBar: AppBar(
            //   iconTheme: const IconThemeData(color: Colors.black),
            //   shadowColor: Colors.transparent,
            //   elevation: 0,
            //   backgroundColor: const Color.fromARGB(255, 54, 224, 247),
            //   title: const Text("Easyload Katha",
            //   style: TextStyle(color: Colors.black),),
            //   centerTitle: true,
            //   actions: [
            //     IconButton(
            //         onPressed: () {
            //           FirebaseAuth.instance.signOut();
            //         },
            //         icon: const Icon(Icons.logout)),

            //     // PopupMenuButton(
            //     //   itemBuilder: ((context) {
            //     //     return ['logout']
            //     //         .map((value) => PopupMenuItem(
            //     //               child: Text(value),
            //     //               value: value,
            //     //             ))
            //     //         .toList();
            //     //   }),
            //     //   onSelected: (value) {
            //     //     switch (value) {
            //     //       case 'logout':
            //     //         FirebaseAuth.instance.signOut();
            //     //     }
            //     //   },
            //     // )
            //   ],
            // ),
            body: StreamBuilder(
              stream: FirebaseAuth.instance.authStateChanges(),
              builder: (context, snapShot) {
                if (snapShot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapShot.hasData) {
                  return const LoggedInPage();
                } else if (snapShot.hasError) {
                  return const Center(
                    child: Text("somethind went wrong"),
                  );
                } else {
                  return const Home();
                }
              },
            ),
          )),
    );
  }
}
