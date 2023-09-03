
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:full_screen_image_null_safe/full_screen_image_null_safe.dart';

import 'package:url_launcher/url_launcher.dart';
import 'package:expandable/expandable.dart';

import '../minor/appbarwidget.dart';


class ProductSliderSecreen extends StatefulWidget {
  final dynamic slider;

  const ProductSliderSecreen({Key? key, required this.slider})
      : super(key: key);

  @override
  State<ProductSliderSecreen> createState() => _ProductSliderSecreenState();
}

class _ProductSliderSecreenState extends State<ProductSliderSecreen> {

  final GlobalKey<ScaffoldMessengerState> _scaffoldKey =
  GlobalKey<ScaffoldMessengerState>();

  late List<dynamic> imagesList = widget.slider['proimage'];

  void _opewhatsApp()async{
    String phoneNumber = '20${widget.slider['whats'].toString()}' ;
    var url = 'http://wa.me/$phoneNumber?text=HelloWorld';
    await launch(url);
  }

  @override
  Widget build(BuildContext context) {

    final Uri url2 = Uri.parse(widget.slider['facebook']);
    final Uri url3 = Uri.parse(widget.slider['youtube']);
    final Uri url = Uri(scheme: 'tel', path: '0${widget.slider['number'].toString()}');


    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          centerTitle: true ,
          title: Text(widget.slider['text'], style: TextStyle(color: Colors.black),),
          leading: AppBarBackButton(),
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // صورة واسم ونوع النشاط
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18.0),
                child: ClipRRect(
                  borderRadius:  BorderRadius.circular(15),
                  child: Image.network(widget.slider['proimage'][0],
                    height: MediaQuery.of(context).size.height*.35,
                    fit: BoxFit.cover,
                    width: double.infinity,
                  ),
                ),
              ),
// الاسم بتاع النشاط والوصف
              const SizedBox(height: 10),

              Container(
                width: MediaQuery.of(context).size.width *0.9,
                decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(10)
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 2,),
                    Text(
                      widget.slider['text'],
                      style: const TextStyle(
                          color: Colors.indigo,
                          fontSize: 18,
                          fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 2,),
                    Text(
                      widget.slider['prodec'],
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                         ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 10),

              FullScreenWidget(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 30),
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height * .6,
                  child: Swiper(
                    pagination: const SwiperPagination(
                        builder: SwiperPagination.dots
                    ),
                    itemBuilder: (context, index) {
                      return Image(
                          image: NetworkImage(imagesList[index]));
                    },
                    itemCount: imagesList.length,
                  ),
                ),
              ),

              const SizedBox(height: 10),
              // ارقام الاتصال والاستفسار

              Container(
                // height: 250,
                width: MediaQuery.of(context).size.width *0.9,
                decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(10)
                ),
                child: Column(
                  children: [
                    const SizedBox(height: 10,),
                    // اتصال
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.call,size: 25,color: Colors.indigo,),
                        const SizedBox(width: 5,),
                        Text(
                          ('   0${widget.slider['number'].toString()}') ,
                          style: const TextStyle(
                              color: Colors.indigo,
                              letterSpacing: 1.5,
                              fontSize: 15,
                              fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                    const SizedBox(height: 5,),
                  ],
                ),
              ),

              const SizedBox(height: 10),

              // الايقونات
              Container(
                width: MediaQuery.of(context).size.width *0.9,
                decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(10)
                ),
                // الايقونات
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    // الواتس اب
                    IconButton(onPressed: (){
                      _opewhatsApp();
                    },
                        icon: FaIcon(FontAwesomeIcons.whatsapp), color: Colors.green,iconSize: 25),
                    // الاتصال
                    IconButton(onPressed: ()async{
                      if(await canLaunchUrl(url)){
                      await launchUrl(url);
                      }else {
                      print('مفيش رقم');
                      }
                      await launchUrl(url);
                    },
                        icon: Icon(Icons.call, color: Colors.indigo,size: 25)),

                    IconButton(onPressed: (){
                      launchUrl(url2);
                    },
                        icon: FaIcon(FontAwesomeIcons.facebook, color: Colors.blue,size: 25)),

                    IconButton(onPressed: (){
                      launchUrl(url3);
                    },
                        icon: FaIcon(FontAwesomeIcons.youtube, color: Colors.red,size: 25)),
                  ],
                ),
              ),

              const SizedBox(height: 10),

              Container(
                width: MediaQuery.of(context).size.width *0.9,
                decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(10)
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(' العنوان ',style: TextStyle(
                        fontSize: 20,
                        color: Colors.indigo
                    ),),
                    const SizedBox(height: 5,),
                    Text(
                      widget.slider['address'],
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.w600),
                    ),

                  ],
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}

