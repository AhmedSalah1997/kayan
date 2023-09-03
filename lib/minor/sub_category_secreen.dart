
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_grid_view.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_tile.dart';

import '../models/products_model.dart';
import 'appbarwidget.dart';

class SubCategoProdutes extends StatefulWidget {
  final String subCategName;
  final String mainCategName;
  final bool fromOnBoarding;

  const SubCategoProdutes(
      {Key? key, required this.subCategName, required this.mainCategName,this.fromOnBoarding=false})
      : super(key: key);

  @override
  State<SubCategoProdutes> createState() => _SubCategoProdutesState();
}

class _SubCategoProdutesState extends State<SubCategoProdutes> {
  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> _prodcutsStream = FirebaseFirestore.instance.collection('products')
        .where('maincateg',isEqualTo:widget.mainCategName)
        .where('subcateg',isEqualTo: widget.subCategName).snapshots();
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.white,
        title: AppBarTitle(title: widget.subCategName),
        leading: widget.fromOnBoarding == true ?
            IconButton(onPressed: (){
              Navigator.pushReplacementNamed(context, '/customer_homescreen');
            }, icon: const Icon(Icons.arrow_back,color: Colors.black,))
        :const AppBarBackButton(),
      ),
      body : StreamBuilder<QuerySnapshot>(
        stream: _prodcutsStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator(color: Colors.purple,),);
          }

          if(snapshot.data!.docs.isEmpty){
            return const Center(child: Text('لا يوجد بيانات \n  حول هذا القسم ' ,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 26 , color: Colors.blueGrey,fontFamily:'Acme', letterSpacing: 1.5),) ,);
          }
          return SingleChildScrollView(
            child: StaggeredGridView.countBuilder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: snapshot.data!.docs.length,
              crossAxisCount: 1,
              staggeredTileBuilder: (context)=> const StaggeredTile.fit(1),
              itemBuilder: (context , index ){
                return ProductModel(product: snapshot.data!.docs[index],);
              },
            ),
          );
        },
      ),
    );
  }
}


