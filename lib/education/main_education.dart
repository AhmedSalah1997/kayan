
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kyan/education/elmonasapat.dart';
import 'package:kyan/education/school/main_school.dart';
import 'package:kyan/education/teacher.dart';

import '../minor/appbarwidget.dart';
import 'abhas/abhas.dart';
import 'bus/main_bus.dart';
import 'low_school.dart';
import 'main_teacher.dart';




class MainEducation extends StatelessWidget {
  const MainEducation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: AppBarBackButton(),
        centerTitle: true,
        title: AppBarTitle( title: 'التعليم',),
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
                    child: Text('الخدمات التعليمية تمي الامديد', style: TextStyle(fontSize: 25),),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      InkWell(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context){
                            return MainTeacher();}));
                        },
                        child: RowShop(
                          textCateory1: 'مواعيد الدروس والامتحانات',
                          photo: 'images/all/ed/out0.png',
                        ),
                      ),
                      InkWell(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context){
                            return Teachers();}));
                        },
                        child: RowShop(
                          textCateory1: 'المعلمين',
                          photo: 'images/all/out/teacher.png',
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
                            return LowSchool();}));
                        },
                        child: RowShop(
                          textCateory1: 'مدارس وحضانات',
                          photo: 'images/all/ed/out2.png',
                        ),
                      ),
                      InkWell(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context){
                            return AbhasHome();}));
                        },
                        child: RowShop(
                          textCateory1: 'نتيجة الامتحانات',
                          photo: 'images/all/ed/out3.png',
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
                            return AbhasHome();}));
                        },
                        child: RowShop(
                          textCateory1: 'تقديمات المدارس',
                          photo: 'images/all/ed/out4.png',
                        ),
                      ),
                      InkWell(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context){
                            return AbhasHome();}));
                        },
                        child: RowShop(
                          textCateory1: 'رسائل ماجستير/دكتوراه',
                          photo: 'images/all/ed/out5.png',
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
                            return AbhasHome();}));
                        },
                        child: RowShop(
                          textCateory1: 'مشاريع تخرج',
                          photo: 'images/all/ed/out5.png',
                        ),
                      ),
                      InkWell(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context){
                            return AbhasHome();}));
                        },
                        child: RowShop(
                          textCateory1: 'التعليم فى الخارج',
                          photo: 'images/all/ed/out9.png',
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
                            return MainSchool();}));
                        },
                        child: RowShop(
                          textCateory1: 'المدارس والجامعات الخاصة',
                          photo: 'images/all/ed/out7.png',
                        ),
                      ),
                      InkWell(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context){
                            return MainBus();}));
                        },
                        child: RowShop(
                          textCateory1: 'مواعيد باصات الجامعة',
                          photo: 'images/all/ed/out8.png',
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
                            return AbhasHome();}));
                        },
                        child: RowShop(
                          textCateory1: 'أبحاث علمية',
                          photo: 'images/all/ed/out1.png',
                        ),
                      ),
                      InkWell(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context){
                            return Elmonaspat();}));
                        },
                        child: RowShop(
                          textCateory1: 'المناسبات الدراسية',
                          photo: 'images/all/ed/out4.png',
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
                child: Image.asset(photo,fit: BoxFit.cover,
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

