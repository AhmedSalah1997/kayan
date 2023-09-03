
import 'package:firebase_auth/firebase_auth.dart';
  import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../minor/appbarwidget.dart';
import '../minor/visitstore.dart';
import '../widgets/alert_dialog.dart';
import 'mange_products.dart';

  List <String> label = [
    ' MyStore',
    'Manage Products',
  ];

  List <IconData> icons = [
    Icons.store,
    Icons.settings,
  ];

  List <Widget> pags=[
    VisitStore(supptId: FirebaseAuth.instance.currentUser!.uid),
    const MangeProd(),
  ];
  class DashboardScreen extends StatelessWidget {
    final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
     DashboardScreen({Key? key}) : super(key: key);

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          elevation: 0,
          backgroundColor: Colors.white,
          title: const AppBarTitle(
            title: 'Dashboard',
          ),
          actions: [
            IconButton(
              onPressed: () {
                MyAlertDialog.showAlertDialog(
                  context: context,
                  title: 'Log Out',
                  descri: 'are you shur to log out',
                  tapNo: (){
                    Navigator.pop(context);
                  },
                  tapYes: ()async{
                    await FirebaseAuth.instance.signOut();
                    final SharedPreferences prf= await _prefs;
                    prf.setString('supplierid', '');
                   await Future.delayed(const Duration(milliseconds: 100)
                   ).whenComplete(() {
                     Navigator.pop(context);
                     Navigator.pushReplacementNamed(context, '/welcome_screen');
                   });
                  },
                );
              },
              icon: const Icon(

                Icons.logout,
                color: Colors.black,
              ),
            ),
          ],
        ),
        body: Container(
          color: Colors.grey.shade300,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: GridView.count(
              mainAxisSpacing: 20,
              crossAxisSpacing: 30,
              crossAxisCount: 2,
              children: List.generate(2, (index) {
                return InkWell(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context){
                     return pags[index];
                    }));
                  },
                  child: Card(
                    shadowColor: Colors.black,
                    elevation: 3,
                    color: Colors.white,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [

                        Icon(icons[index]),
                        Text(
                          label[index],
                          style:const TextStyle(
                            fontSize: 23,
                            letterSpacing: 2,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'acme',
                            color: Colors.black,
                          ),
                        )
                      ],
                    ),
                  ),
                );
              }),
            ),
          ),
        ),
      );
    }
  }
