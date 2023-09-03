

// ignore_for_file: avoid_print


import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../provides/auth_reopo.dart';
import '../widgets/authWiegit.dart';
import '../widgets/button.dart';
import '../widgets/snakebar.dart';


class SupplierLogin extends StatefulWidget {
  const SupplierLogin({Key? key}) : super(key: key);

  @override
  State<SupplierLogin> createState() => _SupplierLoginState();
}

class _SupplierLoginState extends State<SupplierLogin> {

  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  late String email;
  late String password;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldMessengerState> _scaffoldKey =
  GlobalKey<ScaffoldMessengerState>();
  bool passwordVis = false;
  bool prossing = false;
  bool sendEmailValidation = false;

// اختبار تسجيل الدخول
  void logIn() async {
    setState(() {
      prossing = true;
    });
    if (_formKey.currentState!.validate()) {
      try {
        await AuthRepo.signInWithEmailAndPassword(email, password);
        await AuthRepo.reloadUserData();
        _formKey.currentState!.reset();

        User user = FirebaseAuth.instance.currentUser!;
        final SharedPreferences prf= await _prefs;
        prf.setString('supplierid', user.uid);
        print (user.uid);

        Navigator.pushReplacementNamed(context, '/supplier_homescreen');

      } on FirebaseAuthException catch (e) {
        setState(() {
          prossing = false;
        });
        MyMassege.showSnakeBar(_scaffoldKey, e.message.toString());

      }
    } else {
      setState(() {
        prossing = false;
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const HeaderLabel(
                        headerLabel: 'Log in',
                      ),
                      SizedBox(
                        height: 50,
                        child: sendEmailValidation==true ?
                        Center(
                          child: YellowButton(
                            lable: 'Resend Email ',
                            onPress: ()async{
                              try{
                                await FirebaseAuth.instance.currentUser!.sendEmailVerification();
                              }catch(e){
                                print(e);
                              }
                              Future.delayed(const Duration(seconds: 3)).whenComplete(() {
                                setState(() {
                                  sendEmailValidation = false;
                                });
                              });

                            }, width:0.6 ,
                          ),
                        ):const SizedBox(),
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
                      const SizedBox(height: 10,),
                      // ادخال الباسورد مع اختبار ايقونه نظره العين وتفعيلها وعدم تفعيلها
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
                            // label: Text('123456'),
                              suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    passwordVis = !passwordVis;
                                  });
                                },
                                icon: Icon(
                                  passwordVis
                                      ? Icons.visibility
                                      : Icons.visibility_off,
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
                      TextButton(
                        onPressed: (){},
                        child: const Text('Forget Password ?'),
                      ),
                      // ليك حساب ؟؟
                      HaveAccount(
                        onPress: () {
                          Navigator.pushReplacementNamed(context, '/supplier_register');
                        },
                        actionLAbel: 'Sign In',
                        haveAccount: 'don\'t have account',
                      ),
                      // اختبار الدخول
                      prossing == true ? const Center(child:  CircularProgressIndicator(
                        color: Colors.purple,
                      )) : authMainButton(
                        onPress: ()async {
                          logIn();
                        },
                        mainButtonLabel: 'Log In',
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
