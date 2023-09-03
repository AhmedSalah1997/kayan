import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kyan/education/teachers_detials.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_grid_view.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_tile.dart';
import '../minor/appbarwidget.dart';


class Teachers extends StatefulWidget {
  @override
  _TeachersState createState() => _TeachersState();
}

class _TeachersState extends State<Teachers> {

  final controller = PageController(viewportFraction: 0.8, keepPage: true);

  late final Stream<QuerySnapshot> _prodcutsStream = FirebaseFirestore.instance
      .collection('teacher')
      .snapshots();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Colors.grey.shade100,
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        leading: AppBarBackButton(),
        backgroundColor:Colors.grey.shade100,
        title: AppBarTitle(title: 'المعلمين',),
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
                  child: Text('لا يوجد بيانات\n حول هذا القسم ',
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
                  crossAxisCount:2,
                  // crossAxisSpacing: 10,
                  mainAxisSpacing: 15,
                  staggeredTileBuilder: (context)=> const StaggeredTile.fit(1),
                  itemBuilder: (context , index ){
                    return Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              height: MediaQuery.of(context).size.height*.25,
                              width: MediaQuery.of(context).size.width*0.4,
                              color: Colors.white,
                              child: InkWell(
                                onTap: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (context)=>  TeachersDetailsSecreen(teacher: snapshot.data!.docs[index])));
                                },
                                child: Column(
                                  children: [
                                    Expanded(
                                      flex:1,
                                      child: Image.network(snapshot.data!.docs[index]['image'],
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    Text(snapshot.data!.docs[index]['text'],overflow: TextOverflow.ellipsis,maxLines: 1,),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    );
                  },
                ),
              );
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

