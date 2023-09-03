// ignore_for_file: avoid_print
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:kyan/man_screen/delevery.dart';
import '../minor/stores.dart';
import '../minor/visitstore.dart';
import '../services/notification.dart';
import 'home.dart';
import 'main_job.dart';

class CustomerHomeScreen extends StatefulWidget {
  const CustomerHomeScreen({Key? key}) : super(key: key);

  @override
  State<CustomerHomeScreen> createState() => _CustomerHomeScreenState();
}

class _CustomerHomeScreenState extends State<CustomerHomeScreen> {
  int _selcetindex = 0;

  final List<Widget> _tabs = [
    const HomeScreen(),
    const Delevrey(),
    const StoresScreen(),
    MainJobEgar(),
  ];
  displayForgrounNotification() {
    FirebaseMessaging.instance.getInitialMessage();
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Customers App ////Got a message whilst in the foreground!');
      print('Customers App ////Message data: ${message.data}');

      if (message.notification != null) {
        print(
            'Customers App ////Message also contained a notification: ${message.notification}');
        NotificationServices.displayNotification(message);
      }
    });
  }
  Future<void> setupInteractedMessage() async {
    RemoteMessage? initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();

    if (initialMessage != null) {
      _handleMessage(initialMessage);
    }

    FirebaseMessaging.onMessageOpenedApp.listen(_handleMessage);
  }

  void _handleMessage(RemoteMessage message) {
    if (message.data['type'] == 'store') {
      Navigator.push(context, MaterialPageRoute(builder: (context)=> const VisitStore(supptId: "Xvzl3nYo45eMOF5WYs4bXIdXKeb2")));
    }
  }
  // رسائل تونفيكشين
  @override
  void initState() {
    FirebaseMessaging.instance
        .getToken()
        .then((value) => print('token : $value'));
    super.initState();
    displayForgrounNotification();
    setupInteractedMessage();
  }

  @override
  Widget build(BuildContext context) {
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
            label: 'الرئيسية',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.electric_bike),
            label: 'دليفري كيان',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.shop),
            label: 'الاعلانات',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'الوظائف',
          ),
        ],
        onTap: (index) {
          setState(() {
            _selcetindex = index;
          });
        },
      ),
    );
  }
}
