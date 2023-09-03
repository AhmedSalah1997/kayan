import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kyan/education/school/show_school.dart';

import '../../minor/appbarwidget.dart';


class MainSchool extends StatefulWidget {
  @override
  _MainSchoolState createState() => _MainSchoolState();
}

class _MainSchoolState extends State<MainSchool> {


  late final Stream<QuerySnapshot> _prodcutsStream = FirebaseFirestore.instance
      .collection('school')
      .snapshots();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: AppBarBackButton(),
        elevation: 0,
        backgroundColor: Colors.white,
        title: AppBarTitle(title: 'المدارس والجامعات الخاصة',),
      ),
      body: Container(
        color: Colors.grey.shade100,
        child:StreamBuilder<QuerySnapshot>(
            stream: _prodcutsStream,
            builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                return const Text('Something is wrong');
              }
              if (snapshot.connectionState ==
                  ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator(
                  color: Colors.purple,),);
              }
              if (snapshot.data!.docs.isEmpty) {
                return const Center(
                  child: Text('this category \n\n has no item no ',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 26,
                        color: Colors.blueGrey,
                        fontFamily: 'Acme',
                        letterSpacing: 1.5),),);
              }
              return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    return ShowSchool(
                      showSchool : snapshot.data!.docs[index],
                    );
                  });
            }) ,
      ),
    );

  }}

