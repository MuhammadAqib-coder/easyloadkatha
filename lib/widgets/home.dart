import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../services/emial_password_authentication.dart';
import '../services/google_authentication.dart';
import 'text_field.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 80),
      child: ListView(
        children: [
          Field(
            callBack: (email, password, flag) {
              var provider = Provider.of<EmailAndPassword>(context,listen: false);
              if (flag == 'signin') {
                provider
                    .signIn(email, password)
                    .then((error) => _showDialog(context, error));
              } else if (flag == 'signup') {
                provider
                    .createUser(email, password)
                    .then((error) => _showDialog(context, error));
              } else {
                provider
                    .resetPassword(email)
                    .then((error) => _showDialog(context, error));
              }
            },
          ),
          ElevatedButton.icon(
              onPressed: () {
                var provider = Provider.of<Google>(context,listen: false);
                provider.googleLogin();
              },
              style: ElevatedButton.styleFrom(
                  primary: Colors.white,
                  onPrimary: Colors.black,
                  minimumSize: const Size(double.infinity, 50)),
              icon: const FaIcon(
                FontAwesomeIcons.google,
                color: Colors.red,
              ),
              label: const Text("Signin with Google"))
        ],
      ),
    );
  }

  void _showDialog(BuildContext context, String error) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("Alert message"),
            content: Text(error),
          );
        });
  }
}
