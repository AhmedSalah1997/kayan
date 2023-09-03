
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../categroyscreen2/category_widges2.dart';
import '../minor/appbarwidget.dart';
import '../ulited/categ_list.dart';

class Ebtedaey extends StatelessWidget {
  const Ebtedaey({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: (){
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_outlined,color: Colors.black,),
        ),
        title: AppBarTitle( title: 'مواد المرحلة الإبتدائية',),
        backgroundColor: Colors.grey[200],
        centerTitle: true,
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
                      List.generate(primarystage.length -1, (index) {
                        return SubCategModel2(
                          mainCategName: 'primarystage',
                          assetImages: 'images/all/eb/eb$index.png',
                          assetName: primarystage[index +1],
                          subCategLabel: primarystage[index +1],
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

