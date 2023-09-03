// ignore_for_file: library_private_types_in_public_api

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_carousel_slider/carousel_slider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../all_call/number_tawarek.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../causel.dart';
import '../education/main_education.dart';
import '../inapp/main_inapp.dart';
import '../minor/appbarwidget.dart';
import '../minor/search.dart';
import '../moneytoday/money_today.dart';
import '../service/main_service.dart';
import '../service/seyantecar.dart';
import '../service/teby.dart';
import '../shop_category/main_shop_category2.dart';
import '../shop_category/mata3m.dart';
import '../slider/news.dart';
import '../widgets/categ_widges.dart';


// List<ItemData> items = [
//   ItemData(label: 'محلات'),
//   ItemData(label: 'خدمات'),
//   ItemData(label: 'عيادات'),
//   ItemData(label: 'تعليم'),
// ];
// List<IconItem> icons = [
//   IconItem(icon: Icons.home),
//   IconItem(icon: Icons.search),
//   IconItem(icon: Icons.margin),
//   IconItem(icon: Icons.aspect_ratio),
// ];

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  late final Stream<QuerySnapshot> _prodcutsStream =
      FirebaseFirestore.instance.collection('casual').snapshots();

  void _opewhatsApp()async{
    String phoneNumber = '+20 109 064 3343' ;
    var url = 'http://wa.me/$phoneNumber?text=HelloWorld';
    await launch(url);
  }
  final Uri facebook = Uri.parse('https://www.facebook.com/profile.php?id=100070243890807');
  final Uri youtube = Uri.parse('');
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.grey[200],
        elevation: 0,
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return const SearchScreen();
                }));
              },
              icon: Icon(
                Icons.search,
                color: Colors.indigoAccent,
              ))
        ],
        title: AppBarTitle(
          title: 'Kyan',
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: _prodcutsStream,
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return const Text('Something is wrong');
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(
                  color: Colors.purple,
                ),
              );
            }
            if (snapshot.data!.docs.isEmpty) {
              return const Center(
                child: Text(
                  ' لا يوجد بيانات  \n\n   حول هذا القسم ',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 26,
                      color: Colors.blueGrey,
                      fontFamily: 'Acme',
                      letterSpacing: 1.5),
                ),
              );
            }
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [

                    Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        height: MediaQuery.of(context).size.height * 0.28,
                        width: double.infinity,
                        child: InkWell(
                          onTap: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return Casuler();
                            }));
                          },
                          child: CarouselSlider.builder(
                              autoSliderDelay: const Duration(seconds: 5),
                              enableAutoSlider: true,
                              unlimitedMode: true,
                              slideBuilder: (index) {
                                DocumentSnapshot sliderimage =
                                    snapshot.data!.docs[index];
                                return Container(
                                    alignment: Alignment.center,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(15),
                                      child: Image.network(
                                        sliderimage['img'],
                                        height: double.infinity,
                                        width: double.infinity,
                                        fit: BoxFit.fill,
                                      ),
                                    ));
                              },
                              slideTransform: CubeTransform(
                                rotationAngle: 0,
                              ),
                              slideIndicator: CircularSlideIndicator(
                                currentIndicatorColor: Colors.white,
                                padding: EdgeInsets.only(bottom: 5),
                              ),
                              itemCount: snapshot.data!.docs.length),
                        )),

                    // شريط الخدمات
                    const SizedBox(height: 10,),

                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [

                          InkWell(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context){
                                return Call();
                              }));
                            },
                            child: Column(
                              children: [
                                ClipRRect(
                                  child: Image.asset('images/all/call/t.png',fit: BoxFit.fill,
                                    height:MediaQuery.of(context).size.height *.05,
                                    width:MediaQuery.of(context).size.width *.11,
                                  ),
                                ),
                                Text('طوارئ')
                              ],
                            ),
                          ),

                          InkWell(
                            onTap:  (){
                              Navigator.push(context, MaterialPageRoute(builder: (context){
                                return SeyanetCar();
                              }));

                            },
                            child: Column(
                              children: [
                                ClipRRect(
                                  child: Image.asset('images/all/call/c.png',fit: BoxFit.fill,
                                    height:MediaQuery.of(context).size.height *.05,
                                    width:MediaQuery.of(context).size.width *.11,
                                  ),
                                ),
                                Text('سيارات')
                              ],
                            ),
                          ),

                          InkWell(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context){
                                return Teby();
                              }));
                            },
                            child: Column(
                              children: [
                                ClipRRect(
                                  child: Image.asset('images/all/call/d.png',fit: BoxFit.fill,
                                    height:MediaQuery.of(context).size.height *.05,
                                    width:MediaQuery.of(context).size.width *.11,
                                  ),
                                ),
                                Text('طبي')
                              ],
                            ),
                          ),

                          InkWell(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context){
                                return Mata3m();
                              }));
                            },
                            child: Column(
                              children: [
                                ClipRRect(
                                  child: Image.asset('images/all/call/m.png',fit: BoxFit.fill,
                                    height:MediaQuery.of(context).size.height *.05,
                                    width:MediaQuery.of(context).size.width *.11,
                                  ),
                                ),
                                Text('مطاعم')
                              ],
                            ),
                          ),

                        ],
                      ),
                    ),

                    const SizedBox(
                      height: 10,
                    ),

                    InkWell(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context){
                          return MoneyToday();
                        }));
                      },
                      child: Container(
                        height: MediaQuery.of(context).size.height*0.14,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child:
                        Money(),
                      ),
                    ),
                    // شريط الأقسام
                    const Text(
                      ' الأقسام ',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.grey[200],
                      ),
                      height: MediaQuery.of(context).size.height * 0.35,
                      width: double.infinity,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              InkWell(
                                onTap: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (context){
                                    return MainShopCategory2();
                                  }));
                                },
                                child: Container(
                                  height: MediaQuery.of(context).size.height *
                                      0.14,
                                  width:
                                      MediaQuery.of(context).size.width * 0.25,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    color: Colors.white,
                                  ),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                    Image.asset('images/all/out/out2.png',height: MediaQuery.of(context).size.height*.08,),
                                      Text(
                                        'محلات ومطاعم ',
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (context){
                                    return MainInapp();
                                  }));
                                },
                                child: Container(
                                  height: MediaQuery.of(context).size.height *
                                      0.14,
                                  width:
                                      MediaQuery.of(context).size.width * 0.25,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    color: Colors.white,
                                  ),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Image.asset('images/all/out/out0.png',height: MediaQuery.of(context).size.height*.08,),
                                      Text(
                                        'بيع وشراء',
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              InkWell(
                                onTap: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (context){
                                    return MainEducation();
                                  }));
                                },
                                child: Container(
                                  height:
                                      MediaQuery.of(context).size.height * 0.14,
                                  width:
                                      MediaQuery.of(context).size.width * 0.25,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    color: Colors.white,
                                  ),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Image.asset('images/all/out/out1.png',height: MediaQuery.of(context).size.height*.08,),
                                      Text(
                                        'تعليم',
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (context){
                                    return MainServieCategory2();
                                  }));
                                },
                                child: Container(
                                  height:
                                      MediaQuery.of(context).size.height * 0.14,
                                  width:
                                      MediaQuery.of(context).size.width * 0.25,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    color: Colors.white,
                                  ),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Image.asset('images/all/out/out3.png',height: MediaQuery.of(context).size.height*.08,),
                                      Text(
                                        'خدمات',
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),



                    const SizedBox(
                      height: 10,
                    ),

                    Container(
                      height: 40,
                        width: double.infinity,
                        child: News()
                    ),

                    const SizedBox(
                      height: 15,
                    ),
                    // صورة الدليفري
                    Column(
                      children: [
                        const Text(
                          'خدمة التوصيل المقدمة من شركة كيان ',
                          style: TextStyle(
                            color: Colors.indigo,
                              fontSize: 17, fontWeight: FontWeight.bold),
                        ),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(25),
                          child: Container(
                              constraints: const BoxConstraints(
                                minHeight: 100,
                                maxHeight: 200,
                              ),
                              child: Image.asset('images/appicon/de2.jpg')),
                        ),
                      ],
                    ),

                    const SizedBox(
                      height: 10,
                    ),

                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.grey.shade200),
                      child: Column(
                        children: [
                          Text(
                            'Kyan',
                            style: TextStyle(
                                fontSize: 25,
                                color: Colors.indigo,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 5),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            textAlign: TextAlign.center,
                            'شركة متخصصه فى مجال التسويق الإلكتروني ومجال الدعايا الالكترونية وخدمات توصيل الطلبات وادارة صفحات مواقع الفيس بوك واليوتيوب وعمل انترو بشكل إحترافي وبرمجه وتصميم مواقع وصفحات إلكترونية',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                            decoration: BoxDecoration(
                                color: Colors.grey[100],
                                borderRadius: BorderRadius.circular(10)
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                // الواتس اب
                                IconButton(onPressed: ()async{
                                  _opewhatsApp();
                                  setState(() {
                                  });
                                },
                                    icon: FaIcon(FontAwesomeIcons.whatsapp), color: Colors.green,iconSize: 27),
                                // الاتصال
                                IconButton(
                                    onPressed: (){
                                      setState(() async{
                                        try{
                                          final Uri url = Uri(
                                              scheme: 'tel',
                                              path: '20 109 064 3343'
                                          );
                                          if(await canLaunchUrl(url)){
                                            await launchUrl(url);
                                          }else {
                                            print('مفيش رقم');
                                          }
                                          await launchUrl(url);
                                        }catch (e){
                                          print(e);
                                        }
                                      });

                                    },
                                    icon: Icon(Icons.call, color: Colors.indigo,size: 27)),
                                // facebook
                                IconButton(onPressed: (){
                                  launchUrl(facebook);
                                },
                                    icon: FaIcon(FontAwesomeIcons.facebook, color: Colors.blue,size: 27)),
                                //
                                IconButton(onPressed: (){
                                  launchUrl(youtube);
                                },
                                    icon: FaIcon(FontAwesomeIcons.youtube, color: Colors.red,size: 27)),

                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    ClipRRect(
                      borderRadius: BorderRadius.circular(25),
                      child: Container(

                          child: Image.asset('images/appicon/de2.jpg')),
                    ),
                    // KyanDesc(),
                  ],
                ),
              ),
            );
          }),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green,
        onPressed: (){},
        child: IconButton(onPressed: ()async{
          _opewhatsApp();
          setState(() {
          });
        },
            icon: FaIcon(FontAwesomeIcons.whatsapp), color: Colors.white,iconSize: 27),
      )
    );
  }
}

