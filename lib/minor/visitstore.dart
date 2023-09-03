import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_grid_view.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_tile.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../models/products_model.dart';
import '../provides/id_provider.dart';
import 'appbarwidget.dart';
import 'editstore.dart';

class VisitStore extends StatefulWidget {
  final String supptId;

  const VisitStore({Key? key, required this.supptId}) : super(key: key);

  @override
  State<VisitStore> createState() => _VisitStoreState();
}

class _VisitStoreState extends State<VisitStore> {
  bool folloing = false;
String customerId = '';
  List<String> supscriptionList = [];

  checkUserSubscription(){
    FirebaseFirestore.instance
        .collection('suppliers')
        .doc(widget.supptId)
        .collection('subscription')
        .get()
        .then((QuerySnapshot querySnapshot) {
      for (var doc in querySnapshot.docs) {
        supscriptionList.add(doc['customer']);
      }
    }).whenComplete(() {
      folloing = supscriptionList.contains(context.read<IdProvider>().getData);
    });
  }

  subscripToTopic(){
    FirebaseMessaging.instance.subscribeToTopic('salah');
    String id =
        context.read<IdProvider>().getData;
    FirebaseFirestore.instance
        .collection('suppliers')
        .doc(widget.supptId)
        .collection('subscription')
        .doc(id)
        .set({'customer': id});
    setState(() {
      folloing = true;
    });
  }


  unSubscripToTopic(){
    FirebaseMessaging.instance.unsubscribeFromTopic('salah');
    String id =
        context.read<IdProvider>().getData;
    FirebaseFirestore.instance
        .collection('suppliers')
        .doc(widget.supptId)
        .collection('subscription')
        .doc(id)
        .delete();
    setState(() {
      folloing = false;
    });
  }

  @override
  void initState() {
    customerId= context.read<IdProvider>().getData;
    customerId ==''? null : checkUserSubscription();
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    CollectionReference suppliers =
        FirebaseFirestore.instance.collection('suppliers');
    final Stream<QuerySnapshot> prodcutsStream = FirebaseFirestore.instance
        .collection('products')
        .where('sid', isEqualTo: widget.supptId)
        .snapshots();

    return FutureBuilder<DocumentSnapshot>(
      future: suppliers.doc(widget.supptId).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Text("Something went wrong");
        }

        if (snapshot.hasData && !snapshot.data!.exists) {
          return const Text("Document does not exist");
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Material(
            child: Center(
              child: CircularProgressIndicator(
                color: Colors.purple,
              ),
            ),
          );
        }

        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;
          return Scaffold(
            backgroundColor: Colors.grey.shade300,
            appBar: AppBar(
              leading: const YellowBackButton(),
              toolbarHeight: 100,
              flexibleSpace: data['coverimage'] == ''
                  ? Image.asset(
                      'images/inapp/coverimage.jpg',
                      fit: BoxFit.cover,
                    )
                  : Image.network(
                      data['coverimage'],
                      fit: BoxFit.cover,
                    ),
              title: Row(
                children: [
                  Container(
                      height: 80,
                      width: 80,
                      decoration: BoxDecoration(
                          border: Border.all(
                            width: 4,
                            color: Colors.yellow,
                          ),
                          borderRadius: BorderRadius.circular(15)),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.network(
                          data['storlogo'],
                          fit: BoxFit.cover,
                        ),
                      )),
                  SizedBox(
                    height: 100,
                    width: MediaQuery.of(context).size.width * 0.5,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                data['storename'],
                                style: const TextStyle(
                                    fontSize: 20, color: Colors.yellow),
                              ),
                            ),
                          ],
                        ),



                        data['cid'] == FirebaseAuth.instance.currentUser!.uid?
                        Container(
                          height: 35 ,
                          width: MediaQuery.of(context).size.width *0.3,
                          decoration: BoxDecoration(color: Colors.yellow ,
                            border: Border.all(color: Colors.black, width: 3)
                            , borderRadius: BorderRadius.circular(25) ,),
                          child:MaterialButton(
                            onPressed: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context){
                                return  EditStore(data: data,);
                              }));
                            },
                            child:Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: const[
                                Text('Edit'),
                                Icon(Icons.edit,color:Colors.black,)
                              ],
                            ),
                          ) ,
                        )



                            :
                        customerId == ''? const SizedBox(): Container(
                          height: 35,
                          width: MediaQuery.of(context).size.width * 0.3,
                          decoration: BoxDecoration(
                            color: Colors.yellow,
                            border: Border.all(color: Colors.black, width: 3),
                            borderRadius: BorderRadius.circular(25),
                          ),
                          child: MaterialButton(
                            onPressed: folloing == false
                                ? () {
                              subscripToTopic();
                                  }
                                : () {
                              unSubscripToTopic();
                                  },
                            child: folloing == true
                                ? const Text('Following')
                                : const Text('Follow'),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: StreamBuilder<QuerySnapshot>(
                stream: prodcutsStream,
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasError) {
                    return const Text('Something went wrong');
                  }

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Material(
                        child: Center(
                      child: CircularProgressIndicator(
                        color: Colors.purple,
                      ),
                    ));
                  }

                  if (snapshot.data!.docs.isEmpty) {
                    return const Center(
                      child: Text(
                        'this Store \n\n has no item yet ',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 26,
                            color: Colors.blueGrey,
                            fontFamily: 'Acme',
                            letterSpacing: 1.5),
                      ),
                    );
                  }
                  return SingleChildScrollView(
                    child: StaggeredGridView.countBuilder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: snapshot.data!.docs.length,
                      crossAxisCount: 2,
                      staggeredTileBuilder: (context) =>
                          const StaggeredTile.fit(1),
                      itemBuilder: (context, index) {
                        return ProductModel(
                          product: snapshot.data!.docs[index],
                        );
                      },
                    ),
                  );
                },
              ),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {},
              backgroundColor: Colors.green,
              child: const Icon(
                FontAwesomeIcons.whatsapp,
                color: Colors.white,
                size: 40,
              ),
            ),
          );
        }
        return const Text("loading");
      },
    );
  }
}
