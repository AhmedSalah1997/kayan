import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kyan/education/school/shoe_low_school.dart';
import '../../minor/appbarwidget.dart';


class LowSchool extends StatefulWidget {
  @override
  _LowSchoolState createState() => _LowSchoolState();
}

class _LowSchoolState extends State<LowSchool> {

  final controller = PageController(viewportFraction: 0.8, keepPage: true);

  late final Stream<QuerySnapshot> _prodcutsStream = FirebaseFirestore.instance
      .collection('schools')
      .snapshots();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: AppBarBackButton(),
        elevation: 0,
        backgroundColor: Colors.white,
        title: AppBarTitle(title: 'المدارس والحضانات',),
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
                  child: Text('لا يوجد بيانات \n حول هذا القسم',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 26,
                        color: Colors.blueGrey,
                        fontFamily: 'Acme',
                        letterSpacing: 1.5),),);
              }
              return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    return ShowLowSchool(
                      showLowSchool : snapshot.data!.docs[index],
                    );
                  });
            }) ,
      ),
    );

  }}

final colors = const [
  Colors.red,
  Colors.green,
  Colors.greenAccent,
  Colors.amberAccent,
  Colors.blue,
  Colors.amber,
];
