import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../minor/appbarwidget.dart';


class Elmonaspat extends StatefulWidget {
  @override
  _ElmonaspatState createState() => _ElmonaspatState();
}

class _ElmonaspatState extends State<Elmonaspat> {

  final controller = PageController(viewportFraction: 0.8, keepPage: true);

  late final Stream<QuerySnapshot> _prodcutsStream = FirebaseFirestore.instance
      .collection('education')
      .snapshots();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        leading: AppBarBackButton(),
        backgroundColor:Colors.grey.shade100,
        title: AppBarTitle(title: 'المناسبات الدراسية',),
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
                  child: Text('this category \n\n has no item yet ',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 26,
                        color: Colors.blueGrey,
                        fontFamily: 'Acme',
                        letterSpacing: 1.5),),);
              }
              return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    return Container(
                      height: MediaQuery.of(context).size.height*.3,
                      width: double.infinity,
                      padding: EdgeInsets.all(10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(snapshot.data!.docs[index]['title'],
                          style: TextStyle(fontSize: 16),
                          textAlign: TextAlign.center,
                          // maxLines: 2,
                          // overflow: TextOverflow.ellipsis,
                          ),
                         const SizedBox(height: 10,),
                         Expanded(
                           flex: 2,
                           child: Image.network(snapshot.data!.docs[index]['image'],
                           width: double.infinity,
                           height: MediaQuery.of(context).size.height*.5,
                           fit: BoxFit.cover,
                         ),)
                        ],
                      ),

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

