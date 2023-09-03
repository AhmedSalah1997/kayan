
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kyan/service/doctor.dart';

import '../categroyscreen2/category_widges2.dart';
import '../minor/appbarwidget.dart';
import '../ulited/categ_list.dart';

class Teby extends StatelessWidget {
  const Teby({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:  Colors.grey.shade200,
      appBar: AppBar(
        leading: AppBarBackButton(),
        centerTitle: true,
        title: AppBarTitle( title: 'خدمات طبية',),
        backgroundColor: Colors.grey[100],
        elevation: 0,
      ),
      body: Column(
        children: [
          Container(
            color: Colors.grey.shade200,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.8,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child:
                    GridView.count(
                      crossAxisCount: 2,
                      crossAxisSpacing: 0,
                      mainAxisSpacing: 0,
                      children:
                      List.generate(medicalservices.length -1, (index) {
                        return SubCategModel2(
                          mainCategName: 'medicalservices',
                          assetImages: 'images/all/out3/out$index.png',
                          assetName: medicalservices[index +1],
                          subCategLabel: medicalservices[index +1],
                        );
                      }),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton:  FloatingActionButton(
        elevation: 0,
        backgroundColor: Colors.grey.shade200,
        onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context){
          return Doctor();}));},
        child: ClipRRect(
          borderRadius: BorderRadius.circular(100),
          child: Image.asset('images/all/outs/outs19.png',
            height: 70,
            width: 70,
          ),
        ),
      ),
    );

  }
}

