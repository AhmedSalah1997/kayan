
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import 'package:provider/provider.dart';
import '../provides/id_provider.dart';

// const textColor = [
//   Colors.yellowAccent,
//   Colors.blue,
//   Colors.red,
//   Colors.deepOrange,
//   Colors.deepPurple,
// ];
//
// const textStyle = TextStyle(
//   color: Colors.white,
//   fontSize: 45,
//   fontWeight: FontWeight.bold,
// );



class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {

  late AnimationController _controller;

  bool prossing = false;
  CollectionReference anonymous = FirebaseFirestore.instance.collection('anonymous');
  late String _uid;

  @override
  void initState() {
    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 2));
    _controller.repeat();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body:
          SafeArea(
            child: Column(
              children: [
                SizedBox(height: MediaQuery.of(context).size.height*0.2,),
                Image.asset('images/all/out/k.png'),
                SizedBox(height: MediaQuery.of(context).size.height*0.03,),
                Image.asset('images/all/out/a.png',height: MediaQuery.of(context).size.height*0.1,),
                SizedBox(height: MediaQuery.of(context).size.height*0.02,),
                SizedBox(height: MediaQuery.of(context).size.height*0.18,),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 25.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      prossing == true
                          ? const CircularProgressIndicator(color: Colors.white,)
                          : GoogleFacebookLogin(
                        child: Icon(Icons.arrow_circle_right_outlined,color: Colors.white,size: 45,),
                        lable: 'دخول',
                        onPress: () async {
                          setState(() {
                            prossing = true;
                          });
                          await FirebaseAuth.instance
                              .signInAnonymously()
                              .whenComplete(()async
                          {
                            _uid = FirebaseAuth.instance.currentUser!.uid;
                            await anonymous.doc(_uid).set({
                              'name':'',
                              'email':'',
                              'password': '',
                              'profilePhoto':'' ,
                              'address': '',
                              'phone': '',
                              'cid':_uid,
                            }).whenComplete(() {

                              User user = FirebaseAuth.instance.currentUser!;
                              context.read<IdProvider>().setCustomerId(user);
                            });
                          }
                          );
                          Navigator.pushReplacementNamed(
                              context, '/customer_homescreen');
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

    );
  }
}

class AnimatedLogo extends StatelessWidget {
  const AnimatedLogo({
    Key? key,
    required AnimationController controller,
  })  : _controller = controller,
        super(key: key);

  final AnimationController _controller;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Transform.rotate(
          angle: _controller.value * 2 * pi,
          child: child,
        );
      },
      child: const Image(
        image: AssetImage('images/all/out/kyan0.png'),
      ),
    );
  }
}

class GoogleFacebookLogin extends StatelessWidget {
  final String lable;
  final Function() onPress;
  final Widget child;

  const GoogleFacebookLogin(
      {Key? key,
      required this.lable,
      required this.onPress,
      required this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPress,
      child: Column(
        children: [
          SizedBox(height: 50, width: 50, child: child),
          Text(
            lable,
            style: const TextStyle(color: Colors.white, fontSize: 18,fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }
}
