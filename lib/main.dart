// ignore_for_file: avoid_print


import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:kyan/auth/suppler_singup.dart';
import 'package:kyan/auth/supplier_login.dart';
import 'package:kyan/man_screen/cate_se.dart';
import 'package:kyan/provides/id_provider.dart';
import 'package:kyan/services/notification.dart';
import 'package:kyan/welcme/welcome_screen.dart';
import 'package:provider/provider.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get_storage/get_storage.dart';

import 'dashboard/sub_home.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print("Customers App ////Handling a background message: ${message.messageId}");
  print("Handling a background message: ${message.notification!.title}");
  print("Handling a background message: ${message.notification!.body}");
  print("Handling a background message: ${message.data}");
  print("Customers App ////Handling a background message: ${message.data['key1']}");
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await GetStorage.init();
  NotificationServices.createNoificationChanelAndInitialize();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  runApp(MultiProvider(
      providers: [
    ChangeNotifierProvider(create: (_) {
      return IdProvider();
    })
  ], child: const MyApp()));

}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      home:WelcomeScreen(),
      // initialRoute: '/onboarding_screen',
      routes: {
        '/welcome_screen': (context) => const WelcomeScreen(),
        '/customer_homescreen': (context) => const CustomerHomeScreen(),
        '/supplier_homescreen': (context) => const SublayerHomeScreen(),
        '/supplier_register': (context) => const SupplierRegister(),
        '/supplier_login': (context) => const SupplierLogin(),
      },
    );
  }
}
