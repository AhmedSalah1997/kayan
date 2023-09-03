import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:full_screen_image_null_safe/full_screen_image_null_safe.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:expandable/expandable.dart';

import '../minor/appbarwidget.dart';

class ProductJopSecreen extends StatefulWidget {
  final dynamic jop;

  const ProductJopSecreen({Key? key, required this.jop}) : super(key: key);

  @override
  State<ProductJopSecreen> createState() => _ProductJopSecreenState();
}

class _ProductJopSecreenState extends State<ProductJopSecreen> {
  final GlobalKey<ScaffoldMessengerState> _scaffoldKey =
      GlobalKey<ScaffoldMessengerState>();

  late List<dynamic> imagesList = widget.jop['proimage'];

  void _opewhatsApp() async {
    String phoneNumber = '20${widget.jop['whats'].toString()}';
    var url = 'http://wa.me/$phoneNumber?text=HelloWorld';
    await launch(url);
  }

  @override
  Widget build(BuildContext context) {
    // final Uri url2 = Uri.parse(widget.jop['facebook']);
    // final Uri url3 = Uri.parse(widget.jop['youtube']);
    final Uri url =
        Uri(scheme: 'tel', path: '0${widget.jop['number'].toString()}');

    return Material(
      child: SafeArea(
        child: ScaffoldMessenger(
          key: _scaffoldKey,
          child: Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              elevation: 0,
              backgroundColor: Colors.white,
              centerTitle: true,
              title: Text(
                widget.jop['text'],
                style: TextStyle(color: Colors.black),
              ),
              leading: AppBarBackButton(),
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // صورة واسم ونوع النشاط
                    FullScreenWidget(
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 30),
                        width: double.infinity,
                        height: MediaQuery.of(context).size.height * .25,
                        child: Swiper(
                          pagination: const SwiperPagination(
                              builder: SwiperPagination.dots),
                          itemBuilder: (context, index) {
                            return Image(
                                image: NetworkImage(imagesList[index]));
                          },
                          itemCount: imagesList.length,
                        ),
                      ),
                    ),
// الاسم بتاع النشاط والوصف
                    const SizedBox(height: 10),
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: Colors.grey[100],
                          borderRadius: BorderRadius.circular(10)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const SizedBox(
                            height: 2,
                          ),
                          Text(
                            widget.jop['text'],
                            style: const TextStyle(
                                color: Colors.indigo,
                                fontSize: 18,
                                fontWeight: FontWeight.w600),
                          ),
                          const SizedBox(
                            height: 2,
                          ),
                          Text(
                            widget.jop['prodec'],
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    // ارقام الاتصال والاستفسار
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: Colors.grey[100],
                          borderRadius: BorderRadius.circular(10)),
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 10,
                          ),
                          // اتصال
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.call,
                                size: 20,
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Text(
                                ('   0${widget.jop['number'].toString()}'),
                                style: const TextStyle(
                                    color: Colors.indigo,
                                    letterSpacing: 1.5,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 10),
                    // الايقونات
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: Colors.grey[100],
                          borderRadius: BorderRadius.circular(10)),
                      // الايقونات
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          // الواتس اب
                          IconButton(
                              onPressed: () {
                                _opewhatsApp();
                              },
                              icon: FaIcon(FontAwesomeIcons.whatsapp),
                              color: Colors.green,
                              iconSize: 20),
                          // الاتصال
                          IconButton(
                              onPressed: () async {
                                if (await canLaunchUrl(url)) {
                                  await launchUrl(url);
                                } else {
                                  print('مفيش رقم');
                                }
                                await launchUrl(url);
                              },
                              icon: Icon(Icons.call,
                                  color: Colors.indigo, size: 20)),
                          // google
                          // widget.jop['facebook']==' '? const SizedBox():
                          // IconButton(onPressed: (){
                          //   launchUrl(url2);
                          // },
                          //     icon: FaIcon(FontAwesomeIcons.facebook, color: Colors.blue,size: 20)),
                          // // facebook
                          // widget.jop['youtube']==' '? const SizedBox():
                          // IconButton(onPressed: (){
                          //   launchUrl(url3);
                          // },
                          //     icon: FaIcon(FontAwesomeIcons.youtube, color: Colors.red,size: 20)),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    // مواعيد العمل والراتب
                    Container(
                      // height: 250,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: Colors.grey[100],
                          borderRadius: BorderRadius.circular(10)),
                      child: Container(
                        width: double.infinity,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            widget.jop['salary'] == ''
                                ? const SizedBox()
                                : Text(
                                    ('المبلغ :  ') +
                                        ('${widget.jop['salary'].toString()}'),
                                    style: TextStyle(
                                        fontSize: 17, color: Colors.indigo),
                                  ),
                            const SizedBox(
                              height: 5,
                            ),
                            widget.jop['timework'] == ''
                                ? const SizedBox()
                                : Text(
                                    ('مواعيد العمل ') +
                                        ('${widget.jop['timework']}'),
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600),
                                  ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    // العنوان
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: Colors.grey.shade100,
                          borderRadius: BorderRadius.circular(10)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Text(
                            ' العنوان ',
                            style:
                                TextStyle(fontSize: 20, color: Colors.indigo),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            widget.jop['address'],
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
          ),
        ),
      ),
    );
  }
}

class ProDetailsHeader extends StatelessWidget {
  final String label;

  const ProDetailsHeader({Key? key, required this.label}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 60,
            width: 50,
            child: Divider(
              color: Colors.yellow.shade900,
              thickness: 1,
            ),
          ),
          Text(
            label,
            style: TextStyle(
              color: Colors.yellow.shade900,
              fontSize: 23,
            ),
          ),
          SizedBox(
            height: 40,
            width: 50,
            child: Divider(
              color: Colors.yellow.shade900,
              thickness: 1,
            ),
          ),
        ],
      ),
    );
  }
}

Widget reviews(var reviewsStream) {
  return ExpandablePanel(
    header: const Padding(
      padding: EdgeInsets.all(10),
      child: Text(
        'Reviews',
        style: TextStyle(
            color: Colors.blue, fontSize: 24, fontWeight: FontWeight.bold),
      ),
    ),
    collapsed: SizedBox(
      height: 230,
      child: reviewsAll(reviewsStream),
    ),
    expanded: reviewsAll(reviewsStream),
  );
}

Widget reviewsAll(var reviewsStream) {
  return StreamBuilder<QuerySnapshot>(
    stream: reviewsStream,
    builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot2) {
      if (snapshot2.connectionState == ConnectionState.waiting) {
        return const Center(
          child: CircularProgressIndicator(
            color: Colors.purple,
          ),
        );
      }

      if (snapshot2.data!.docs.isEmpty) {
        return const Center(
          child: Text(
            'this Item \n\n has Reviews item yet ',
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 26,
                color: Colors.blueGrey,
                fontFamily: 'Acme',
                letterSpacing: 1.5),
          ),
        );
      }
      return ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: snapshot2.data!.docs.length,
          itemBuilder: (context, index) {
            return ListTile(
              leading: CircleAvatar(
                backgroundImage:
                    NetworkImage(snapshot2.data!.docs[index]['profileimage']),
              ),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(snapshot2.data!.docs[index]['name']),
                  Row(
                    children: [
                      Text(snapshot2.data!.docs[index]['rate'].toString()),
                      const Icon(
                        Icons.star,
                        color: Colors.amber,
                      )
                    ],
                  )
                ],
              ),
              subtitle: Text(snapshot2.data!.docs[index]['comment']),
            );
          });
    },
  );
}
