import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kyan/shop_category/camera.dart';
import 'package:kyan/shop_category/lawazembenaa.dart';
import 'package:kyan/shop_category/mobedat.dart';
import 'package:kyan/shop_category/monazefffat.dart';
import 'package:kyan/shop_category/more.dart';
import 'package:kyan/shop_category/shoes_malabes.dart';
import 'package:kyan/shop_category/shop_category.dart';
import 'package:kyan/shop_category/werash_maszne3.dart';

import '../minor/appbarwidget.dart';
import 'homegredtant.dart';
import 'homelawzem.dart';
import 'maktabat.dart';
import 'mata3m.dart';
import 'mobile.dart';
import 'mostahdarat.dart';
import 'nazarat.dart';
import 'otoor.dart';

class MainShopCategory2 extends StatelessWidget {
  const MainShopCategory2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: AppBarBackButton(),
        title: AppBarTitle(
          title: 'kyan',
        ),
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
              Padding(
                padding: EdgeInsets.only(left: 15, bottom: 28, right: 15),
                child: Text(
                  'محلات ومطاعم تمي الأمديد',
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
                        return Mata3m();
                      }));
                    },
                    child: RowShop(
                      photo: 'images/all/shop/shop9.png',
                      textCateory1: 'مطاعم وكافيهات',
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return ShopCat2();
                      }));
                    },
                    child: RowShop(
                      photo: 'images/all/shop/shop0.png',
                      textCateory1: 'أغذية ومشروبات',
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
                        return ShoseMalabes();
                      }));
                    },
                    child: RowShop(
                      photo: 'images/all/shop/shop11.png',
                      textCateory1: 'ملابس وأحذية',
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return HomeGradent();
                      }));
                    },
                    child: RowShop(
                      photo: 'images/all/shop/shop1.png',
                      textCateory1: 'أثاث ومفروشات',
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
                        return Mobile();
                      }));
                    },
                    child: RowShop(
                      photo: 'images/all/shop/shop13.png',
                      textCateory1: 'موبايلات وكمبيوتر',
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return Otoor();
                      }));
                    },
                    child: RowShop(
                      photo: 'images/all/shop/shop4.png',
                      textCateory1: 'عطور وبرفانات',
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
                        return Mostahdarat();
                      }));
                    },
                    child: RowShop(
                      photo: 'images/all/shop/shop8.png',
                      textCateory1: 'مستحضرات تجميل',
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return Maktabat();
                      }));
                    },
                    child: RowShop(
                      textCateory1: 'مكتبات وهدايا',
                      photo: 'images/all/shop/shop10.png',
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
                        return Nazarat();
                      }));
                    },
                    child: RowShop(
                      textCateory1: 'نظارات وبصريات',
                      photo: 'images/all/shop/shop14.png',
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return HomeLawazem();
                      }));
                    },
                    child: RowShop(
                      photo: 'images/all/shop/shop3.png',
                      textCateory1: 'لوازم المنزل',
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
                        return Lawazembenaa();
                      }));
                    },
                    child: RowShop(
                      textCateory1: 'لوازم تشطيبات',
                      photo: 'images/all/shop/shop5.png',
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return Monazefat();
                      }));
                    },
                    child: RowShop(
                      textCateory1: 'منظفات وبلاستيكات',
                      photo: 'images/all/shop/shop12.png',
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
                        return WerashMasan3();
                      }));
                    },
                    child: RowShop(
                      textCateory1: 'ورش ومصانع',
                      photo: 'images/all/shop/shop15.png',
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return Camera();
                      }));
                    },
                    child: RowShop(
                      textCateory1: 'أنظمة امنية وكاميرات',
                      photo: 'images/all/shop/shop3.png',
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
                        return Mobedat();
                      }));
                    },
                    child: RowShop(
                      textCateory1: 'مبيدات حشرية',
                      photo: 'images/all/shop/shop7.png',
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return More();
                      }));
                    },
                    child: RowShop(
                      textCateory1: 'المزيد',
                      photo: 'images/all/shop/shop2.png',
                    ),
                  ),
                ],
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
          height: MediaQuery.of(context).size.height * .24,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15), color: Colors.white),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Image.asset(
                    photo,
                    fit: BoxFit.fill,
                    height: MediaQuery.of(context).size.height * .18,
                    width: MediaQuery.of(context).size.width * .37,
                  )),
              Text(
                textCateory1,
                style: TextStyle(fontWeight: FontWeight.bold),
              )
            ],
          ),
        ),
      ],
    );
  }
}
