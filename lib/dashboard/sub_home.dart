import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:kyan/dashboard/upload_data_toapp.dart';

import '../man_screen/delevery.dart';
import '../man_screen/home.dart';
import '../minor/stores.dart';
import '../services/notification.dart';
import 'dash_board.dart';

class SublayerHomeScreen extends StatefulWidget {
  const SublayerHomeScreen({Key? key}) : super(key: key);

  @override
  State<SublayerHomeScreen> createState() => _SublayerHomeScreenState();
}

class _SublayerHomeScreenState extends State<SublayerHomeScreen> {
  int _selcetindex = 0;
  final List<Widget> _tabs = [
    const HomeScreen(),
    const Delevrey(),
    const StoresScreen(),
    DashboardScreen(),
    const UpLoadeDataToApp(),
  ];
  @override
  void initState() {
    super.initState();
    FirebaseMessaging.instance.getInitialMessage();
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Got a message whilst in the foreground!');
      print('Message data: ${message.data}');

      if (message.notification != null) {
        print('Message also contained a notification: ${message.notification}');
        NotificationServices.displayNotification(message);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('orders')
          .where('sid', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
          .where('deliverystatus', isEqualTo: 'preparing')
          .snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Material(
            child: Center(
              child: CircularProgressIndicator(
                color: Colors.purple,
              ),
            ),
          );
        }

        return Scaffold(
          body: _tabs[_selcetindex],
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            elevation: 0,
            selectedLabelStyle: const TextStyle(fontWeight: FontWeight.w600),
            selectedItemColor: Colors.black,
            unselectedItemColor: Colors.blueAccent,
            currentIndex: _selcetindex,
            items: [
              const BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              const BottomNavigationBarItem(
                icon: Icon(Icons.search),
                label: 'Category',
              ),
              const BottomNavigationBarItem(
                icon: Icon(Icons.shop),
                label: 'Stores',
              ),
              BottomNavigationBarItem(
                icon: const SizedBox(),
                //  Badge (
                //     showBadge: snapshot.data!.docs.isEmpty? false:true,
                //     padding:const EdgeInsets.all(2),
                //     badgeColor: Colors.yellow,
                //     badgeContent: Text(
                //       snapshot.data!.docs.length.toString()
                //       , style:const  TextStyle(fontSize: 16 , fontWeight:FontWeight.w600 ),),
                //     child:const Icon(Icons.dashboard)),
                label: 'Dashboard',
              ),
              const BottomNavigationBarItem(
                icon: Icon(Icons.upload),
                label: 'Upload',
              ),
            ],
            onTap: (index) {
              setState(() {
                _selcetindex = index;
              });
            },
          ),
        );
      },
    );
  }
}
