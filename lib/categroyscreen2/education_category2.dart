

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../minor/appbarwidget.dart';
import '../ulited/categ_list.dart';
import 'category_widges2.dart';

class EducationCategory2 extends StatelessWidget {
  const EducationCategory2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: AppBarBackButton(),
        title: AppBarTitle( title: 'تعليم',),
        backgroundColor: Colors.white,
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
                  height: MediaQuery.of(context).size.height * 0.70,
                  child: GridView.count(
                    crossAxisCount: 2,
                    crossAxisSpacing: 5,
                    mainAxisSpacing: 10,
                    children: List.generate(education.length -1, (index) {
                      return Container(
                        // color: Colors.green,
                        // height: 80,
                        child: SubCategModel2(
                          mainCategName: 'education',
                          assetImages: 'images/clinics/beauty$index.jpg',
                          assetName: education[index +1],
                          subCategLabel: education[index +1],
                        ),
                      );
                    }),
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

