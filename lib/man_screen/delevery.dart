import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_grid_view.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_tile.dart';
import 'package:url_launcher/url_launcher.dart';

import '../minor/appbarwidget.dart';
import '../models/products_model.dart';

class Delevrey extends StatefulWidget {

  const Delevrey({Key? key,}) : super(key: key);

  @override
  State<Delevrey> createState() => _DelevreyState();
}

class _DelevreyState extends State<Delevrey> {

  void _opewhatsApp()async{
    String phoneNumber = '201090643343' ;
    var url = 'http://wa.me/$phoneNumber?text=HelloWorld';
    await launch(url);
  }

  final Uri facebook = Uri.parse('https://www.facebook.com/profile.php?id=100070243890807');
  final Uri youtube = Uri.parse('');
  final Uri url = Uri(scheme: 'tel', path: '01090643343');


  late final Stream<QuerySnapshot> _prodcutsStream = FirebaseFirestore.instance
      .collection('products')
      .where('isdelvery', isEqualTo: 'no')
      .snapshots();

  @override
  Widget build(BuildContext context) {
        return  Scaffold(
            appBar: AppBar(
              centerTitle: true,
              elevation: 0,
              backgroundColor: Colors.white,
              title: AppBarTitle(
                title: 'Kyan Delevery',
              ),
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  // mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // صورة دليفرري كيان
                    Container(
                      height: 200,
                      child: ClipRRect(
                        borderRadius:  BorderRadius.circular(25),
                        child: Container(
                            child: Image.asset('images/appicon/de2.jpg')),
                      ),
                    ),

                    const SizedBox(height: 7,),
                    // نص توضيحي
                    const Text(
                      'تقدم شركة كيان خدمات التوصيل للمنازل \n من خلال باقات اشتراكات أسبوعية شهرية '
                      ,textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 15,
                      ),
                    ),
                    const SizedBox(height: 10,),
                    // مواعيد العمل
                    Container(
                      padding: EdgeInsets.all(15),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.grey[100],
                      ),
                      child: Column(
                        children: [
                          Text('مواعيد عمل الخدمة ', style: TextStyle(fontSize: 18, color: Colors.indigo),),
                          Text('يتم العمل خلال الفتره من الساعه 9 صباحا حتي الساعه 12 منتصف الليل',textAlign: TextAlign.center,)
                        ],
                      ),
                    ),
                    const SizedBox(height: 7,),
                    const Text('التواصل مع الخدمة',style: TextStyle(fontSize: 15, color: Colors.indigo),),
                    // التواصل مع خدمات الدليفري
                    Container(
                      width: MediaQuery.of(context).size.width *0.9,
                      decoration: BoxDecoration(
                          color: Colors.grey.shade100,
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
                          // google
                          IconButton(onPressed: (){
                            launchUrl(facebook);
                          },
                              icon: FaIcon(FontAwesomeIcons.facebook, color: Colors.blue,size: 25)),
                          // facebook
                        ],
                      ),
                    ),
                    const SizedBox(height: 10,),
                    // تفصيلي بيان باسعار التوصيل
                    Container(
                      padding: EdgeInsets.all(2),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.grey.shade100,
                      ),
                      child: Column(
                        // mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center ,
                        children: [
                          Text('إشتراك الخدمة ', style: TextStyle(fontSize: 15, color: Colors.indigo),),
                          Text('تكون التكلفة للطلب الواحد 5 جنيهات داخل المدينة وتحسب التكلفه خارجها ',textAlign: TextAlign.center)
                        ],
                      ),
                    ),
                    const SizedBox(height: 10,),
                    const Text('المجالات المشتركة فى الخدمة',style: TextStyle(fontSize: 15, color: Colors.indigo),),

                     StreamBuilder<QuerySnapshot>(
                     stream: _prodcutsStream,
                      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (snapshot.hasError) {
                          return const Text('Something is wrong');
                        }
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(child: CircularProgressIndicator(
                            color: Colors.indigo,),);
                        }

                        if (snapshot.data!.docs.isEmpty) {
                          return const Center(
                            child: Text('this category \n\n has no item yet ',
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 26,
                                  color: Colors.blueGrey,
                                  fontFamily: 'Acme',
                                  letterSpacing: 1.5),),);
                        }
                        return SizedBox(
                          child: SingleChildScrollView(
                            child: StaggeredGridView.countBuilder(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: snapshot.data!.docs.length,
                              crossAxisCount: 2,
                              staggeredTileBuilder: (context) =>
                              const StaggeredTile.fit(1),
                              itemBuilder: (context, index) {
                                return ProductModel(
                                  product: snapshot.data!.docs[index],
                                );
                              },
                            ),
                          ),
                        );
                      })]
                ),
              ),
            )
        );









  }
}


class ItemDataDelever {
  String label;
  IconData icond;
  bool isSelected;
  ItemDataDelever({required this.label, required this.icond, this.isSelected = false});
}

