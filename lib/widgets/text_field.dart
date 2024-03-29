import 'package:flutter/material.dart';
import 'package:practice_of_firebase/widgets/button.dart';

import '../services/dimension.dart';

class Field extends StatefulWidget {
  const Field({Key? key, required this.callBack}) : super(key: key);
  final void Function(String email, String password, String flag) callBack;

  @override
  State<Field> createState() => _FieldState();
}

class _FieldState extends State<Field> {
  final _formKey = GlobalKey<FormState>();

  final _emailControler = TextEditingController();

  final _passwordControler = TextEditingController();

  var _visibility = false;
  var _textVisibility = true;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Padding(
        padding:
            EdgeInsets.only(left: Dimension.width10, right: Dimension.width10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(20)),
              child: const Image(
                height: 150,
                width: 400,
                fit: BoxFit.cover,
                image: AssetImage(
                  "assest/easyload5.png",
                ),
              ),
            ),
            TextFormField(
              cursorColor: Colors.black,
              keyboardType: TextInputType.emailAddress,
              controller: _emailControler,
              decoration: InputDecoration(
                  fillColor: Colors.grey.withOpacity(0.5),
                  filled: true,
                  hintText: "enter email",
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(Dimension.height10),
                      borderSide: BorderSide(
                          color: Colors.black, width: Dimension.width2)),
                  // errorBorder: OutlineInputBorder(
                  //     borderRadius: BorderRadius.circular(10),
                  //     borderSide: BorderSide(color: Colors.black, width: 2)),
                  focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(Dimension.height10),
                      borderSide: BorderSide(
                          color: Colors.black, width: Dimension.width2)),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(Dimension.height10),
                      borderSide: BorderSide(
                          color: Colors.black, width: Dimension.width2))),
              validator: (value) {
                if (value!.isEmpty) {
                  return "email is required";
                }
                return null;
              },
            ),
            SizedBox(
              height: Dimension.height10,
            ),
            TextFormField(
              cursorColor: Colors.black,
              obscureText: _textVisibility,
              autocorrect: false,
              enableSuggestions: false,
              controller: _passwordControler,
              decoration: InputDecoration(
                  suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          _visibility = !_visibility;
                          _textVisibility = !_textVisibility;
                        });
                      },
                      icon: Icon(
                        _visibility ? Icons.visibility : Icons.visibility_off,
                        color: Colors.black,
                      )),
                  fillColor: Colors.grey.withOpacity(0.5),
                  filled: true,
                  //labelStyle: const TextStyle(color: Colors.black),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(Dimension.height10),
                      borderSide: BorderSide(
                          color: Colors.black, width: Dimension.width2)),
                  focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(Dimension.height10),
                      borderSide: BorderSide(
                          color: Colors.black, width: Dimension.width2)),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(Dimension.height10),
                      borderSide: BorderSide(
                          color: Colors.black, width: Dimension.width2)),
                  hintText: "enter password"),
              validator: (value) {
                if (value!.isEmpty) {
                  return "password is required";
                }
                return null;
              },
            ),
            SizedBox(
              height: Dimension.height6,
            ),
            // Button(
            //     child: const Text("forget password?"),
            //     onPressed: () {
            //       if (_formKey.currentState!.validate()) {
            //         widget.callBack(
            //             _emailControler.text, _passwordControler.text, "reset");
            //       }
            //     }),
            SizedBox(
              height: Dimension.height20,
            ),
            Align(
              alignment: Alignment.center,
              child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      widget.callBack(_emailControler.text,
                          _passwordControler.text, "signin");
                    }
                  },
                  style: ElevatedButton.styleFrom(primary: Colors.black),
                  child: const Text("SignIn")),
            ),
            SizedBox(
              height: Dimension.height50,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("don'\t have an account?"),
                SizedBox(
                  width: Dimension.width10,
                ),
                ElevatedButton(
                    child: const Text('SignUp'),
                    style: ElevatedButton.styleFrom(primary: Colors.black),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        widget.callBack(_emailControler.text,
                            _passwordControler.text, "signup");
                      }
                    })
              ],
            ),
            SizedBox(
              height: Dimension.height30,
            ),

            //TextButton.icon(onPressed: (){}, icon: const Icon(Icons.g_mobiledata), label: const Text("signIn with google")),
            //  InkWell(
            //    onTap: (){

            //    },
            //    splashColor: Colors.brown.withOpacity(0.5),
            //    child: Row(
            //      mainAxisAlignment: MainAxisAlignment.start,
            //      children: [
            //      SizedBox(
            //        height: 30,
            //        width: 30,
            //        child: Image.asset('assest/google.png')),
            //      const Text("sign with google")
            //    ],)
            //  )
            // ElevatedButton(onPressed: (){}, child: Row(children: [
            //   Image.asset('assest/google.png'),
            //   const Text("sign in with google")
            // ],))
            // MaterialButton(
            // color: Colors.white,
            // onPressed: (){},
            // child: Row(
            //   mainAxisAlignment: MainAxisAlignment.start,
            //   children: [
            //     Container(
            //       width: 40,
            //       height: 40,
            //       decoration: const BoxDecoration(
            //         image: DecorationImage(
            //           image: AssetImage('assest/google.png'),
            //           //fit: BoxFit.cover
            //         ),
            //         shape: BoxShape.circle
            //       ),
            //     ),
            //     const SizedBox(width: 24,),
            //     const Text("signin with google")
            //   ],
            // ),)
          ],
        ),
      ),
    );
  }
}
