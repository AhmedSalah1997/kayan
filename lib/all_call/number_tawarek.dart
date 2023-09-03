
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_grid_view.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_tile.dart';
import 'package:url_launcher/url_launcher.dart';

import '../minor/appbarwidget.dart';

class Call extends StatefulWidget {

  const Call(
      {Key? key,})
      : super(key: key);

  @override
  State<Call> createState() => _CallState();
}

class _CallState extends State<Call> {
  @override
  Widget build(BuildContext context) {

    final Stream<QuerySnapshot> _prodcutsStream = FirebaseFirestore.instance
        .collection('emergencynumbers').snapshots();

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        elevation: 0,
        title: Text('أرقام الطوارئ', style: TextStyle(color: Colors.black),),
        centerTitle: true,
        backgroundColor: Colors.grey.shade100,
        leading: const AppBarBackButton(),
      ),

      body: StreamBuilder<QuerySnapshot>(
        stream: _prodcutsStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(color: Colors.purple,),);
          }

          if (snapshot.data!.docs.isEmpty) {
            return const Center(child: Text('لا يوجد بيانات \n  حول هذا القسم ',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 26,
                  color: Colors.blueGrey,
                  fontFamily: 'Acme',
                  letterSpacing: 1.5),),);
          }

          return SingleChildScrollView(
            child: StaggeredGridView.countBuilder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: snapshot.data!.docs.length,
              crossAxisCount: 1,
              staggeredTileBuilder: (context) => const StaggeredTile.fit(1),
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(top: 35, right: 15,left: 15),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.blue[400]
                        ),
                        padding: const EdgeInsets.all(15),
                        height: MediaQuery.of(context).size.height *0.09,
                        width: double.infinity,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                              icon: Icon(Icons.call),color: Colors.white,
                              onPressed: (){
                                setState(() async{
                                  try{
                                    final Uri url = Uri(
                                        scheme: 'tel',
                                        path: '${snapshot.data!.docs[index]['number'].toString()}'
                                    );
                                    if(await canLaunchUrl(url)){
                                      await launchUrl(url);
                                    }else {
                                      print('مفيش رقم');
                                    }
                                    await launchUrl(url);
                                  }catch (e){
                                    print(e);
                                  }
                                });

                              },
                            ),
                            Text('${snapshot.data!.docs[index]['number']}'.toString(),style: TextStyle(fontSize: 20,color: Colors.white),),
                            Text(snapshot.data!.docs[index]['label'],style: TextStyle(fontSize: 20,color: Colors.white)),
                          ],
                        ),
                      )
                    ],
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }

}

