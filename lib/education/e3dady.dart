
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kyan/education/subeducationmodel.dart';

import '../minor/appbarwidget.dart';
import '../ulited/categ_list.dart';

class E3dady extends StatelessWidget {
  const E3dady({Key? key}) : super(key: key);

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
        title: AppBarTitle( title: 'مواد المرحلة الإعدادية',),
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
                      List.generate(middleschool.length -1, (index) {
                        return SubEducationModel(
                          mainCategName: 'middleschool',
                          assetImages: 'images/all/e/e$index.png',
                          assetName: middleschool[index +1],
                          subCategLabel: middleschool[index +1],
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

