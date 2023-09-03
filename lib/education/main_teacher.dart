import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kyan/education/e3dady.dart';
import 'package:kyan/education/test/test.dart';
import 'package:kyan/education/thanawy.dart';

import '../minor/appbarwidget.dart';
import 'ebtedaey.dart';

class MainTeacher extends StatelessWidget {
  const MainTeacher({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        leading: AppBarBackButton(),
        centerTitle: true,
        title: AppBarTitle(
          title: 'المراحل التعليمية',
        ),
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
              Padding(
                padding: EdgeInsets.only(left: 15, bottom: 28, right: 15),
                child: Text(
                  'المراحل التعليمية  تمي الامديد',
                  style: TextStyle(fontSize: 25),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return Ebtedaey();
                      }));
                    },
                    child: RowShop(
                      textCateory1: 'المرحلة الإبتدائية',
                      photo: 'images/all/ed/out2.png',
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return E3dady();
                      }));
                    },
                    child: RowShop(
                      textCateory1: 'المرحلة الإعدادية',
                      photo: 'images/all/ed/out2.png',
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return Thanawy();
                      }));
                    },
                    child: RowShop(
                      textCateory1: 'المرحلة الثانوية',
                      photo: 'images/all/ed/out2.png',
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return Test();
                      }));
                    },
                    child: RowShop(
                      textCateory1: 'جدول الامتحانات',
                      photo: 'images/all/ed/out2.png',
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      )),
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
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: MediaQuery.of(context).size.width * .38,
          height: MediaQuery.of(context).size.height * .25,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15), color: Colors.white),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ClipRRect(
                child: Image.asset(
                  photo,
                  fit: BoxFit.cover,
                  height: MediaQuery.of(context).size.height * .18,
                  width: MediaQuery.of(context).size.width * .37,
                ),
              ),
              Text(
                textCateory1,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              )
            ],
          ),
        ),
      ],
    );
  }
}
