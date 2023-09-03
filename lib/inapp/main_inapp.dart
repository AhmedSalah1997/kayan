
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kyan/education/elmonasapat.dart';
import 'package:kyan/education/school/main_school.dart';
import 'package:kyan/inapp/cars.dart';
import 'package:kyan/inapp/perfumes_and_cosmetics.dart';
import 'package:kyan/inapp/plan.dart';
import 'package:kyan/inapp/real_estate.dart';

import '../minor/appbarwidget.dart';
import '../shop_category/more.dart';
import 'accessories.dart';
import 'clothes_and_shoes.dart';
import 'homesupplies.dart';
import 'kitchen_tools.dart';
import 'miscellaneous.dart';
import 'more.dart';


class MainInapp extends StatelessWidget {
  const MainInapp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: AppBarBackButton(),
        centerTitle: true,
        title: AppBarTitle( title: 'البيع والشراء',),
        backgroundColor: Colors.grey.shade200,
        elevation: 0,
      ),
      body: SingleChildScrollView(
          child: Container(
            color: Colors.grey.shade200,
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                children: [
                  Padding(padding: EdgeInsets.only(left: 15, bottom: 28 , right:  15),
                    child: Text('البيع والشراء تمي الأمديد', style: TextStyle(fontSize: 25),),
                  ),

                  const SizedBox(height: 20,),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      InkWell(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context){
                            return CarsPay();}));
                        },
                        child: RowShop(
                          textCateory1: 'سيارات',
                          photo: 'images/all/pay/c.png',
                        ),
                      ),
                      InkWell(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context){
                            return RealEstate();}));
                        },
                        child: RowShop(
                          textCateory1: 'عقارات',
                          photo: 'images/all/pay/h.png',
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      InkWell(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context){
                            return Plan();}));
                        },
                        child: RowShop(
                          textCateory1: 'أراضي زراعية',
                          photo: 'images/all/pay/p.png',
                        ),
                      ),
                      InkWell(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context){
                            return HomeSupplies();}));
                        },
                        child: RowShop(
                          textCateory1: 'مستلزمات المنزل',
                          photo: 'images/all/pay/hh.png',
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      InkWell(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context){
                            return KtchenTools();}));
                        },
                        child: RowShop(
                          textCateory1: 'مستلزمات المطبخ',
                          photo: 'images/all/pay/g.png',
                        ),
                      ),
                      InkWell(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context){
                            return Accessories();}));
                        },
                        child: RowShop(
                          textCateory1: 'إكسسوارات',
                          photo: 'images/all/pay/e.png',
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      InkWell(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context){
                            return ClothesandShoes();}));
                        },
                        child: RowShop(
                          textCateory1: 'ملابس وأحذية',
                          photo: 'images/all/pay/cl.png',
                        ),
                      ),
                      InkWell(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context){
                            return PerfumesandCosmetics();}));
                        },
                        child: RowShop(
                          textCateory1: 'عطور ومستحضرات تجميل',
                          photo: 'images/all/pay/o.png',
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      InkWell(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context){
                            return Miscellaneous();}));
                        },
                        child: RowShop(
                          textCateory1: 'متنوعات',
                          photo: 'images/all/pay/f.png',
                        ),
                      ),
                      InkWell(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context){
                            return MorePay();}));
                        },
                        child: RowShop(
                          textCateory1: 'المزيد',
                          photo: 'images/all/pay/m.png',
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20,),
                ],
              ),
            ),
          )
      ),
    );

  }
}

class RowShop extends StatelessWidget {

  final String textCateory1;
  final String photo;


  const RowShop({
    required this.textCateory1,
    required this.photo,

    Key? key,
  }) : super(key: key);



  @override
  Widget build(BuildContext context)  {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width:MediaQuery.of(context).size.width *.38,
          height: MediaQuery.of(context).size.height *.25,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Colors.white
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ClipRRect(
                child: Image.asset(photo,fit: BoxFit.contain,
                  height:MediaQuery.of(context).size.height *.19,
                  width:MediaQuery.of(context).size.width *.37,
                ),
              ),
              Text(textCateory1,
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.bold), overflow: TextOverflow.ellipsis, maxLines: 1,)
            ],
          ),
        ),
      ],
    );
  }
}

