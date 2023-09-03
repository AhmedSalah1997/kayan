// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import '../find_jop/find_jop1.dart';

class AddShop extends StatefulWidget {
  const AddShop({Key? key}) : super(key: key);

  @override
  State<AddShop> createState() => _AddShopState();
}

final GlobalKey<ScaffoldMessengerState> _scaffoldKey =
    GlobalKey<ScaffoldMessengerState>();

class _AddShopState extends State<AddShop> {
  late String number1;
  late String whats;
  late String proName;
  late String prodesc;
  late String address;
  late String proId;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool proeccing = false;

// رفع البيانات على الفاير بيز
  void uploadData() async {
    CollectionReference productRef =
        FirebaseFirestore.instance.collection('addshop');
    proId = const Uuid().v4();
    await productRef.doc(proId).set({
      'proid': proId,
      'number1': number1,
      'whats': whats,
      'proname': proName,
      'address': address,
      'prodec': prodesc,
      // 'sid':FirebaseAuth.instance.currentUser!.uid,
    }).whenComplete(() {
      setState(() {
        proeccing = false;
      });
      _formKey.currentState!.reset();
    });
  }

  // void uploadProduct()async{
  //   await uploadData();
  // }

  @override
  Widget build(BuildContext context) {
    // var size = MediaQuery.of(context).size ;
    return ScaffoldMessenger(
      key: _scaffoldKey,
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            reverse: true,
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  FindJop(),
                  TextButton(onPressed: () {}, child: Text('تبديل مستخدمين '))
                ],
              ),
            ),
          ),
        ),
        floatingActionButton: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(
              width: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: FloatingActionButton(
                onPressed: proeccing == true
                    ? null
                    : () {
                        uploadData();
                      },
                backgroundColor: Colors.blueAccent,
                child: proeccing == true
                    ? const CircularProgressIndicator(
                        color: Colors.purple,
                      )
                    : const Icon(
                        Icons.upload,
                        color: Colors.black,
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

var textFormDecration = InputDecoration(
  labelText: 'price',
  hintText: 'price..',
  labelStyle: const TextStyle(color: Colors.purple),
  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
  enabledBorder: OutlineInputBorder(
    borderSide: const BorderSide(color: Colors.black54, width: 1),
    borderRadius: BorderRadius.circular(10),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: const BorderSide(color: Colors.black54, width: 1),
    borderRadius: BorderRadius.circular(10),
  ),
);
