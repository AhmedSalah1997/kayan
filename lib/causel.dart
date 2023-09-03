import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kyan/slider/show_slider.dart';

import 'minor/appbarwidget.dart';


class Casuler extends StatefulWidget {
  @override
  _CasulerState createState() => _CasulerState();
}

class _CasulerState extends State<Casuler> {

  final controller = PageController(viewportFraction: 0.8, keepPage: true);

  late final Stream<QuerySnapshot> _prodcutsStream = FirebaseFirestore.instance
      .collection('slider')
      .snapshots();

  @override
  Widget build(BuildContext context) {
    // final pages = List.generate(
    //     2,
    //         (index) =>
    //         Container(
    //           decoration: BoxDecoration(
    //             borderRadius: BorderRadius.circular(16),
    //             color: Colors.grey.shade300,
    //           ),
    //           margin: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
    //           child: Container(
    //             height: 180,
    //             width: double.infinity,
    //             child: Center(
    //                 child: Image.asset(
    //                   'images/bank/bank$index.jpg', fit: BoxFit.cover,)
    //             ),
    //           ),
    //         ));
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.grey[100],
        title: AppBarTitle(title: 'الاعــــلانات'),
        leading: AppBarBackButton(),
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
                  child: Text('لا يوجد بيانات',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 26,
                        color: Colors.blueGrey,
                        fontFamily: 'Acme',
                       ),),);
              }
              return Padding(
                padding: const EdgeInsets.all(20.0),
                child: GridView.builder(
                    itemCount: snapshot.data!.docs.length,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                    ),
                    itemBuilder: ((context, index) {
                      return ShowSlider(slider: snapshot.data!.docs[index]);
                    })),
              );
            }) ,
      ),
    );

}}

// final colors = const [
//   Colors.red,
//   Colors.green,
//   Colors.greenAccent,
//   Colors.amberAccent,
//   Colors.blue,
//   Colors.amber,
// ];
