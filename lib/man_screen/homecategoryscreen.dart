
import 'package:flutter/material.dart';

import '../categroyscreen2/education_category2.dart';
import '../freaaprofessions/freepro.dart';
import '../freaaprofessions/jop_egar.dart';
import '../minor/appbarwidget.dart';
import '../service/main_service.dart';
import '../shop_category/main_shop_category2.dart';
import 'delevery.dart';


class HomeCateroeyScreen extends StatefulWidget {
  const HomeCateroeyScreen({Key? key}) : super(key: key);

  @override
  State<HomeCateroeyScreen> createState() => _HomeCateroeyScreenState();
}

class _HomeCateroeyScreenState extends State<HomeCateroeyScreen> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: AppBarTitle(title:'جميع الأقسام'),
        elevation: 0,
        centerTitle: true,
        leading: AppBarBackButton(),
        backgroundColor: Colors.grey.shade100,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(30),
          color: Colors.grey[100],
          // height: size.height*0.8,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AppBarTitle(title: ' الأنشطه والخدمات   '),
              const SizedBox(height: 17,),
              // محلات خدمات
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  // محلات
                  InkWell(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context){
                        return MainShopCategory2();
                      }));
                    },
                    child:RowCateory(
                        photo: 'images/all/out/store0.jpg',
                        textCateory1: 'المحلات',

                    ),
                  ),
                   // خدمات
                  InkWell(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context){
                        return MainServieCategory2();
                      }));
                    },
                    child:RowCateory(
                        photo: 'images/all/out/65.jpg',
                        textCateory1: 'الخدمات',

                    ),
                  ),
                ],
              ),
              const SizedBox(height: 17,),
              // سيارات بنوك
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  // بنوك
                  InkWell(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context){
                        return FreeProd();
                      }));
                    },
                    child:RowCateory(
                        photo: 'images/all/out/42.jpg',
                        textCateory1: 'الصنايعية',

                    ),
                  ),
                  // سيارات
                  InkWell(
                    onTap: (){
                      // Navigator.push(context, MaterialPageRoute(builder: (context){
                      //   return CarsCat2();
                      // }));
                    },
                    child:RowCateory(
                        photo: 'images/all/out/mobile.jpg',
                        textCateory1: 'البيع والشراء',

                    ),
                  ),
                ],
              ),
              const SizedBox(height: 17,),
              // تعليم تحاليل
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  // تحاليل عيادات
                  InkWell(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context){
                        return Delevrey();
                      }));
                    },
                    child:RowCateory(
                        photo: 'images/all/out/mobile.jpg',
                        textCateory1: 'دليفري كيان',

                    ),
                  ),
                  // تعليم
                  InkWell(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context){
                        return EducationCategory2();
                      }));
                    },
                    child:RowCateory(
                        photo: 'images/all/out/mobile.jpg',
                        textCateory1: 'التعليم',

                    ),
                  ),
                ],
              ),
              const SizedBox(height: 17,),
              // صيانه ومهن حره
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  // مهن حره
                  InkWell(
                    onTap: (){},
                    //   Navigator.push(context, MaterialPageRoute(builder: (context){
                    //     return JopEgar();
                    //   }));
                    // },
                    child:RowCateory(
                        photo: 'images/all/out/mobile.jpg',
                        textCateory1: 'وظائف وايجارات',

                    ),
                  ),
                  // صيانه
                  InkWell(
                    onTap: (){
                      // Navigator.push(context, MaterialPageRoute(builder: (context){
                      //   return MaintenancecenterCategory2();
                      // }));
                    },
                    child:RowCateory(
                        photo: 'images/all/out/mobile.jpg',
                        textCateory1: 'المزيد',

                    ),
                  ),
                ],
              ),
              const SizedBox(height: 17,),
            ],
          ),
        ),
      ),
    );
  }
}

class RowCateory extends StatelessWidget {

  final String textCateory1;
  final String photo;

  const RowCateory({
    required this.textCateory1,
    required this.photo,
    Key? key,

  }) : super(key: key);



  @override
  Widget build(BuildContext context)  {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Container(
          width:MediaQuery.of(context).size.width *.3,
          height: MediaQuery.of(context).size.height *.198,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Colors.white
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Image.asset(photo,fit: BoxFit.cover,)),
              Text(textCateory1)
            ],
          ),
        ),
      ],
    );
  }
}







