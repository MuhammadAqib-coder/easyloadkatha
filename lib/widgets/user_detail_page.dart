import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:practice_of_firebase/models/price_and_date_model.dart';

import '../services/dimension.dart';

class UserDetail extends StatefulWidget {
  final QueryDocumentSnapshot snapshot;
  String? id;
  UserDetail({Key? key, required this.snapshot}) : super(key: key);

  @override
  State<UserDetail> createState() => _UserDetailState();
}

class _UserDetailState extends State<UserDetail> with WidgetsBindingObserver {
  final _formKey = GlobalKey<FormState>();
  final _loadControler = TextEditingController();
  final _priceControler = TextEditingController();
  int advance = 0;
  int total = 0;

  CollectionReference? reference;

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
    widget.id = widget.snapshot.id;
    advance = widget.snapshot['advance'];
    total = widget.snapshot['total'];
    reference = FirebaseFirestore.instance
        .collection('users/${widget.id}/${widget.snapshot['name']}');
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.snapshot['name']}'),
        centerTitle: true,
        shadowColor: Colors.transparent,
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: EdgeInsets.all(Dimension.height6),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(Dimension.height10),
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.24,
              decoration: BoxDecoration(
                  color: Colors.grey, borderRadius: BorderRadius.circular(10)),
              child: Column(
                children: [
                  Row(children: [
                    Expanded(
                      child: TextField(
                        keyboardType: TextInputType.number,
                        controller: _priceControler,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            // errorStyle: const TextStyle(fontSize: 0),
                            focusedErrorBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.circular(Dimension.height10),
                                borderSide: BorderSide(
                                    color: Colors.black,
                                    width: Dimension.width2)),
                            // errorBorder: OutlineInputBorder(
                            //     borderRadius:
                            //         BorderRadius.circular(Dimension.height10),
                            //     borderSide: BorderSide(
                            //         color: Colors.black,
                            //         width: Dimension.width2)),
                            focusedBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.circular(Dimension.height10),
                                borderSide: BorderSide(
                                    color: Colors.black,
                                    width: Dimension.width2)),
                            fillColor: Colors.grey.withOpacity(0.5),
                            filled: true,
                            labelText: "price from customer",
                            labelStyle: const TextStyle(
                              color: Colors.black,
                            ),
                            enabledBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.circular(Dimension.height10),
                                borderSide: BorderSide(
                                    color: Colors.black,
                                    width: Dimension.width2))),
                      ),
                    ),
                    SizedBox(
                      width: Dimension.width10,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        if (_priceControler.text.isNotEmpty) {
                          var price = int.parse(_priceControler.text.trim());
                          _priceControler.clear();
                          if (total > 0) {
                            total -= price;
                            if (total <= 0) {
                              advance = total.abs();
                              total = 0;
                              setState(() {});
                            } else {
                              setState(() {});
                            }
                          } else {
                            advance += price;
                            setState(() {});
                          }
                          var time = DateTime.now();
                          var date = DateFormat('dd-MM-yyyy').format(time);
                          var data =
                              PriceAndDate(price: price.toString(), date: date);
                          reference!.add(data.toMap());
                        } else {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return const AlertDialog(
                                  content: Text("Please filled the form"),
                                );
                              });
                        }
                      },
                      style: ElevatedButton.styleFrom(primary: Colors.black),
                      child: const Text("submit"),
                    ),
                  ]),
                  SizedBox(
                    height: Dimension.height10,
                  ),
                  Row(
                    children: [
                      Expanded(
                        // height: MediaQuery.of(context).size.height * 0.1,
                        // width: MediaQuery.of(context).size.width * 0.7,
                        child: TextField(
                          // validator: (value) {
                          //   if (value!.isEmpty) {
                          //     return "please enter price";
                          //   } else {
                          //     return null;
                          //   }
                          // },
                          keyboardType: TextInputType.number,
                          controller: _loadControler,
                          decoration: InputDecoration(
                              //errorStyle: const TextStyle(fontSize: 0),
                              fillColor: Colors.grey.withOpacity(0.5),
                              filled: true,
                              labelText: "load price",
                              labelStyle: const TextStyle(color: Colors.black),
                              focusedErrorBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.circular(Dimension.height10),
                                  borderSide: BorderSide(
                                      color: Colors.black,
                                      width: Dimension.width2)),
                              // errorBorder: OutlineInputBorder(
                              //     borderRadius:
                              //         BorderRadius.circular(Dimension.height10),
                              //     borderSide: BorderSide(
                              //         color: Colors.black,
                              //         width: Dimension.width2)),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.circular(Dimension.height10),
                                  borderSide: BorderSide(
                                      color: Colors.black,
                                      width: Dimension.width2)),
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.black,
                                      width: Dimension.width2),
                                  borderRadius: BorderRadius.circular(
                                      Dimension.height10))),
                        ),
                      ),
                      SizedBox(
                        width: Dimension.width10,
                      ),
                      ElevatedButton(
                          onPressed: () {
                            if (_loadControler.text.isNotEmpty) {
                              int load = int.parse(_loadControler.text.trim());
                              _loadControler.clear();
                              var time = DateTime.now();
                              var date = DateFormat('dd-MM-yyyy').format(time);
                              var data = PriceAndDate(
                                  price: load.toString(),
                                  date: date.toString());
                              if (advance > 0) {
                                advance -= load;
                                if (advance <= 0) {
                                  total = advance.abs();
                                  advance = 0;
                                  setState(() {});
                                } else {
                                  setState(() {});
                                }
                              } else {
                                total += load;
                                setState(() {});
                              }
                              reference!.add(data.toMap());
                            } else {
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return const AlertDialog(
                                      content: Text("Please filled the form"),
                                    );
                                  });
                            }
                          },
                          style: ElevatedButton.styleFrom(
                              primary: Colors.black, fixedSize: Size(65, 30)),
                          child: const Text("save"))
                    ],
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Expanded(
                child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('users/${widget.id}/${widget.snapshot['name']}')
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return const Text("somethig went wrong");
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  //return const Text("please wait");
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (snapshot.hasData) {
                  return ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      return Card(
                        color: Colors.grey,
                        shape: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        child: ListTile(
                          iconColor: Colors.black,
                          textColor: Colors.black,
                          shape: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                          title: Text(snapshot.data!.docs[index]['price']),
                          subtitle: Text(snapshot.data!.docs[index]['date']),
                          trailing: IconButton(
                              onPressed: () async {
                                await FirebaseFirestore.instance
                                    .runTransaction((transaction) async {
                                  transaction.delete(
                                      snapshot.data!.docs[index].reference);
                                });
                              },
                              icon: const Icon(Icons.delete)),
                        ),
                      );
                    },
                  );
                }
                return Container(
                  child: const Center(child: Text("no data found")),
                );
              },
            )),
            const SizedBox(
              height: 5.0,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  RichText(
                      text: TextSpan(
                          style: const TextStyle(color: Colors.black),
                          text: "Advance Rs ",
                          children: [
                        TextSpan(
                            text: "$advance",
                            style: const TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold))
                      ])),
                  RichText(
                      text: TextSpan(
                          style: const TextStyle(color: Colors.black),
                          text: "Total Rs ",
                          children: [
                        TextSpan(
                            text: "$total",
                            style: const TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold))
                      ]))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  void deactivate() {
    FirebaseFirestore.instance
        .collection('users')
        .doc(widget.id)
        .update({'total': total, 'advance': advance});
    super.deactivate();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    switch (state) {
      case AppLifecycleState.paused:
        FirebaseFirestore.instance
            .collection('users')
            .doc(widget.id)
            .update({'advance': advance, 'total': total});
        break;
      case AppLifecycleState.resumed:
        break;
      case AppLifecycleState.inactive:
        break;
      case AppLifecycleState.detached:
        break;
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }
}
