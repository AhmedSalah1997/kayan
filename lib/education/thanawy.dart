
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../categroyscreen2/category_widges2.dart';
import '../minor/appbarwidget.dart';
import '../ulited/categ_list.dart';

class Thanawy extends StatelessWidget {
  const Thanawy({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          onPressed: (){
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_outlined,color: Colors.black,),
        ),
        title: AppBarTitle( title: 'مواد المرحلة الثانوية',),
        backgroundColor: Colors.grey[200],
        elevation: 0,
      ),
      body: Container(
        color: Colors.grey.shade200,
        child: Column(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.80,
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child:
                    GridView.count(
                      crossAxisCount: 2,
                      crossAxisSpacing: 0,
                      mainAxisSpacing: 0,
                      children:
                      List.generate(highschool.length -1, (index) {
                        return SubCategModel2(
                          mainCategName: 'highschool',
                          assetImages: 'images/all/sh/sh$index.png',
                          assetName: highschool[index +1],
                          subCategLabel: highschool[index +1],
                        );
                      }),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );

  }
}

