
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kyan/service/darykean.dart';
import 'package:kyan/service/photo.dart';
import 'package:kyan/service/quraan.dart';
import 'package:kyan/service/salonregaly.dart';
import 'package:kyan/service/seyantecar.dart';
import 'package:kyan/service/spoort.dart';
import 'package:kyan/service/takeef.dart';
import 'package:kyan/service/tarfeh.dart';
import 'package:kyan/service/teby.dart';
import '../freaaprofessions/freepro.dart';
import '../minor/appbarwidget.dart';
import 'car_motosekl.dart';
import 'da3ayae3lan.dart';
import 'doctor.dart';
import 'engenner.dart';
import 'gam3yat.dart';
import 'hafalat.dart';
import 'lawer.dart';
import 'mekapartest.dart';


class MainServieCategory2 extends StatelessWidget {
  const MainServieCategory2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: AppBarBackButton(),
        title: AppBarTitle( title: 'خدمات',),
        centerTitle: true,
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
                    child: Text('خدمات تمي الامديد', style: TextStyle(fontSize: 25),),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      InkWell(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context){
                            return Teby();}));
                        },
                        child: RowShop(
                          textCateory1: 'خدمات طبية',
                          photo: 'images/all/outs/outs8.PNG',
                        ),
                      ),
                      InkWell(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context){
                            return Doctor();}));
                        },
                        child: RowShop(
                          textCateory1: 'أطباء',
                          photo: 'images/all/outs/outs19.png',
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
                            return SalonRegaly();}));
                        },
                        child: RowShop(
                          textCateory1: 'صالون رجالى',
                          photo: 'images/all/outs/outs10.png',
                        ),
                      ),
                      InkWell(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context){
                            return Gam3yat();}));
                        },
                        child: RowShop(
                          textCateory1: 'جمعيات خيرية',
                          photo: 'images/all/outs/outs1.png',
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
                            return Qraan();}));
                        },
                        child: RowShop(
                          textCateory1: 'تحفيظ القران',
                          photo: 'images/all/outs/outs5.png',
                        ),
                      ),
                      InkWell(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context){
                            return Lawer();}));
                        },
                        child: RowShop(
                          textCateory1: 'محامين',
                          photo: 'images/all/outs/outs2.png',
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
                            return Eng();}));
                        },
                        child: RowShop(
                          textCateory1: 'مهندسين',
                          photo: 'images/all/outs/outs13.png',
                        ),
                      ),
                      InkWell(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context){
                            return Da3aya();}));
                        },
                        child: RowShop(
                          textCateory1: 'دعايا واعلان',
                          photo: 'images/all/outs/outs9.png',
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
                            return Photo();}));
                        },
                        child: RowShop(
                          textCateory1: 'تصوير فوتوغرافي',
                          photo: 'images/all/outs/outs6.png',
                        ),
                      ),
                      InkWell(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context){
                            return Takeef();}));
                        },
                        child: RowShop(
                          textCateory1: 'تكيفات وفلاتر مياه',
                          photo: 'images/all/outs/outs7.png',
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
                            return DrayKelen();}));
                        },
                        child: RowShop(
                          textCateory1: 'دراي كلين ومغسله',
                          photo: 'images/all/outs/outs11.png',
                        ),
                      ),
                      InkWell(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context){
                            return Sports();}));
                        },
                        child: RowShop(
                          textCateory1: 'نادي رياضي',
                          photo: 'images/all/outs/outs15.png',
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
                            return Tarfeh();}));
                        },
                        child: RowShop(
                          textCateory1: 'أماكن ترفيه',
                          photo: 'images/all/outs/outs4.png',
                        ),
                      ),
                      InkWell(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context){
                            return Hafalat();}));
                        },
                        child: RowShop(
                          textCateory1: 'قاعات وتنظيم حفلات',
                          photo: 'images/all/outs/outs12.png',
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
                            return CarMotosekl();}));
                        },
                        child: RowShop(
                          textCateory1: 'خدمات النقل والمواصلات',
                          photo: 'images/all/outs/outs16.PNG',
                        ),
                      ),
                      InkWell(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context){
                            return MekabArtest();}));
                        },
                        child: RowShop(
                          textCateory1: 'ميكب أرتست',
                          photo: 'images/all/outs/outs14.png',
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
                            return FreeProd();}));
                        },
                        child: RowShop(
                          textCateory1: 'مهن حره',
                          photo: 'images/all/outs/outs17.png',
                        ),
                      ),
                      InkWell(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context){
                            return SeyanetCar();
                          }));
                        },
                        child: RowShop(
                          textCateory1: 'خدمات السيارات',
                          photo: 'images/all/outs/out18.png',
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
          height: MediaQuery.of(context).size.height *.24,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Colors.white
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.asset(photo,fit: BoxFit.cover,
                  height:MediaQuery.of(context).size.height *.18,
                  width:MediaQuery.of(context).size.width *.37,
                ),
              ),
              Text(textCateory1, style: TextStyle(fontWeight: FontWeight.bold))
            ],
          ),
        ),
      ],
    );
  }
}

