// ignore_for_file: avoid_print

import 'dart:io';


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../widgets/authWiegit.dart';
import '../widgets/snakebar.dart';

class SupplierRegister extends StatefulWidget {
  const SupplierRegister({Key? key}) : super(key: key);

  @override
  State<SupplierRegister> createState() => _SupplierRegisterState();
}

class _SupplierRegisterState extends State<SupplierRegister> {

  late String storeName;

  late String email;

  late String password;
  late String storeLogo;
  late String _uid;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldMessengerState> _scaffoldKey =
  GlobalKey<ScaffoldMessengerState>();
  bool passwordVis = false;
  bool prossing = false;

  final ImagePicker _imagePicker = ImagePicker();

  dynamic _pickedImageError;
  XFile? _imageFile;
  CollectionReference suppliers = FirebaseFirestore.instance.collection('suppliers');

// اخذ صورة من كاميرا لهاتف
  void _pickeimageFromCamera() async {
    try {
      final pickeImage = await _imagePicker.pickImage(
          source: ImageSource.camera,
          maxHeight: 300,
          maxWidth: 300,
          imageQuality: 95);
      setState(() {
        _imageFile = pickeImage;
      });
    } catch (e) {
      setState(() {
        _pickedImageError = e;
      });
      print(_pickedImageError);
    }
  }

// اخذ صورة من الاستوديو للهاتف
  void _pickeimageFromGallery() async {
    try {
      final pickeImage = await _imagePicker.pickImage(
          source: ImageSource.gallery,
          maxHeight: 300,
          maxWidth: 300,
          imageQuality: 95);
      setState(() {
        _imageFile = pickeImage;
      });
    } catch (e) {
      setState(() {
        _pickedImageError = e;
      });
      print(_pickedImageError);
    }
  }

  void singUp() async {
    setState(() {
      prossing = true ;
    });
    if (_formKey.currentState!.validate()) {
      if (_imageFile != null) {
        try {
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: email,
            password: password,
          );
          firebase_storage.Reference ref = firebase_storage
              .FirebaseStorage.instance
              .ref('supp-images/$email.jpg');

          await ref.putFile(File(_imageFile!.path));
          _uid = FirebaseAuth.instance.currentUser!.uid ;

          storeLogo = await ref.getDownloadURL();
          await suppliers.doc(_uid).set({
            'storename':storeName,
            'email':email,
            'password': password,
            'storlogo':storeLogo,
            'address': 'ash',
            'phone': '010145752',
            'cid':_uid,
            'coverimage':'',
          });
          _formKey.currentState!.reset();
          setState(() {
            _imageFile = null;
          });
          Navigator.pushReplacementNamed(context, '/supplier_homescreen');
        } on FirebaseAuthException catch (e) {
          if (e.code == 'weak-password') {
            setState(() {
              prossing = false ;
            });
            MyMassege.showSnakeBar(
                _scaffoldKey, 'The password provided is too weak.');
          } else if (e.code == 'email-already-in-use') {
            setState(() {
              prossing = false ;
            });
            MyMassege.showSnakeBar(
                _scaffoldKey, 'The account already exists for that email.');
          }
        } catch (e) {
          print(e);
        }

      } else {
        setState(() {
          prossing = false ;
        });
        MyMassege.showSnakeBar(_scaffoldKey, 'please  picke image first');
      }
      // print(' valid');
    } else {
      setState(() {
        prossing = false ;
      });
      MyMassege.showSnakeBar(_scaffoldKey, 'please fill all files');
    }
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldMessenger(
      key: _scaffoldKey,
      child: Scaffold(
        body: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              reverse: true,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const HeaderLabel(
                        headerLabel: 'Sing Up',
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 20.0, horizontal: 40.0),
                            child: CircleAvatar(
                              radius: 60,
                              backgroundColor: Colors.purpleAccent,
                              backgroundImage: _imageFile == null
                                  ? null
                                  : FileImage(File(_imageFile!.path)),
                            ),
                          ),
                          Column(
                            children: [
                              Container(
                                decoration: const BoxDecoration(
                                  color: Colors.purple,
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(15),
                                    topRight: Radius.circular(15),
                                  ),
                                ),
                                child: IconButton(
                                  icon: const Icon(
                                    Icons.camera_alt,
                                    color: Colors.white,
                                  ),
                                  onPressed: () {
                                    _pickeimageFromCamera();
                                  },
                                ),
                              ),
                              Container(
                                decoration: const BoxDecoration(
                                  color: Colors.purple,
                                  borderRadius: BorderRadius.only(
                                    bottomRight: Radius.circular(15),
                                    bottomLeft: Radius.circular(15),
                                  ),
                                ),
                                child: IconButton(
                                  icon: const Icon(
                                    Icons.photo,
                                    color: Colors.white,
                                  ),
                                  onPressed: () {
                                    _pickeimageFromGallery();
                                  },
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                        child: TextFormField(
                          validator: (value) {
                            if (value!.isEmpty) {
                              return ' Enter Your name';
                            }
                            return null;
                          },
                          decoration: textFormDecoration.copyWith(
                              labelText: 'Full Name',
                              hintText: '  '),
                          onChanged: (value) {
                            storeName = value;
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                        child: TextFormField(
                          validator: (value) {
                            if (value!.isEmpty) {
                              return ' Enter Your email';
                            } else if (value.isValidEmail() == false) {
                              return 'inValid Email';
                            } else if (value.isValidEmail() == true) {
                              return null;
                            }
                            return null;
                          },
                          keyboardType: TextInputType.emailAddress,
                          decoration: textFormDecoration.copyWith(
                              labelText: 'Email Address',
                              hintText: ''),
                          onChanged: (value) {
                            email = value;
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                        child: TextFormField(
                          validator: (value) {
                            if (value!.isEmpty) {
                              return ' Enter Your password';
                            }
                            return null;
                          },
                          obscureText: passwordVis,
                          decoration: textFormDecoration.copyWith(
                              suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    passwordVis = !passwordVis;
                                  });
                                },
                                icon: Icon(
                                  passwordVis
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                  color: Colors.purple,
                                ),
                              ),
                              labelText: 'Password',
                              hintText: ''),
                          onChanged: (value) {
                            password = value;
                          },
                        ),
                      ),
                      HaveAccount(
                        onPress: () {
                          Navigator.pushReplacementNamed(context, '/supplier_login');
                        },
                        actionLAbel: 'Log In',
                        haveAccount: 'already have account',
                      ),
                      prossing == true ? const CircularProgressIndicator(color: Colors.purple,) : authMainButton(
                        onPress: ()async {
                          singUp();
                        },
                        mainButtonLabel: 'Sing In',
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
