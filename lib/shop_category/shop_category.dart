
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../categroyscreen2/category_widges2.dart';
import '../minor/appbarwidget.dart';
import '../ulited/categ_list.dart';

class ShopCat2 extends StatelessWidget {
  const ShopCat2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: AppBarBackButton(),
        centerTitle: true,
        title: AppBarTitle( title: 'أغذية ومشروبات',),
        backgroundColor: Colors.grey[200],
        elevation: 0,
      ),
      body: Container(
        color: Colors.grey.shade200,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: MediaQuery.of(context).size.height*.8,
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: GridView.count(
                  crossAxisCount: 2,
                  crossAxisSpacing: 0,
                  mainAxisSpacing: 0,
                  children:
                  List.generate(shop.length -1, (index) {
                    return Container(
                      child: SubCategModel2(
                        mainCategName: 'shop',
                        assetImages: 'images/all/drink/out$index.png',
                        assetName: shop[index +1],
                        subCategLabel: shop[index +1],
                      ),
                    );
                  }),
                ),
              ),
            ),
          ],
        ),
      ),
    );

  }
}

