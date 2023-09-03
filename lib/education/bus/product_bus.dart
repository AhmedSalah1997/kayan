
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:expandable/expandable.dart';

import '../../minor/appbarwidget.dart';


class ProductBusSecreen extends StatefulWidget {
  final dynamic bus;

  const ProductBusSecreen({Key? key, required this.bus})
      : super(key: key);

  @override
  State<ProductBusSecreen> createState() => _ProductBusSecreenState();
}

class _ProductBusSecreenState extends State<ProductBusSecreen> {

  final GlobalKey<ScaffoldMessengerState> _scaffoldKey =
  GlobalKey<ScaffoldMessengerState>();



  void _opewhatsApp()async{
    String phoneNumber = '20${widget.bus['whats'].toString()}' ;
    var url = 'http://wa.me/$phoneNumber?text=HelloWorld';
    await launch(url);
  }

  @override
  Widget build(BuildContext context) {
    final Uri url2 = Uri.parse(widget.bus['facebook']);
    final Uri url3 = Uri.parse(widget.bus['youtube']);
    final Uri url = Uri(scheme: 'tel', path: '0${widget.bus['number'].toString()}');


    return Material(
      child: SafeArea(
        child: ScaffoldMessenger(
          key: _scaffoldKey,
          child: Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              elevation: 0,
              backgroundColor: Colors.white,
              centerTitle: true ,
              title: Text(widget.bus['text'], style: TextStyle(color: Colors.black),),
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
                      child: Container(
                          constraints:const BoxConstraints(minHeight: 150, maxHeight: 200,),
                          child: Image(
                            image: NetworkImage(widget.bus['image']),fit: BoxFit.cover,)
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
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const SizedBox(height: 2,),
                            Text(
                              widget.bus['name'],
                              style: const TextStyle(
                                  color: Colors.indigo,
                                  fontSize: 25,
                                  fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                      ],
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
                        widget.bus['number'] == 0
                            ? const SizedBox(height: 0,)
                            : Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.call,size: 25,),
                            const SizedBox(width: 5,),
                            Text(
                              ('   0${widget.bus['number'].toString()}') ,
                              style: const TextStyle(
                                  color: Colors.indigo,
                                  letterSpacing: 1.5,
                                  fontSize: 18,
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
                  // Container(
                  //   width: MediaQuery.of(context).size.width *0.9,
                  //   decoration: BoxDecoration(
                  //       color: Colors.grey[100],
                  //       borderRadius: BorderRadius.circular(10)
                  //   ),
                  //   // الايقونات
                  //   child: Row(
                  //     mainAxisAlignment: MainAxisAlignment.spaceAround,
                  //     children: [
                  //       // الواتس اب
                  //       IconButton(onPressed: (){
                  //         _opewhatsApp();
                  //       },
                  //           icon: FaIcon(FontAwesomeIcons.whatsapp), color: Colors.green,iconSize: 25),
                  //       // الاتصال
                  //       IconButton(onPressed: ()async{
                  //
                  //         if(await canLaunchUrl(url)){
                  //           await launchUrl(url);
                  //         }else {
                  //           print('مفيش رقم');
                  //         }
                  //         await launchUrl(url);
                  //       },
                  //           icon: Icon(Icons.call, color: Colors.indigo,size: 25)),
                  //       // google
                  //       IconButton(onPressed: (){
                  //         launchUrl(url2);
                  //       },
                  //           icon: FaIcon(FontAwesomeIcons.facebook, color: Colors.blue,size: 25)),
                  //       // facebook
                  //       IconButton(onPressed: (){
                  //         launchUrl(url3);
                  //       },
                  //           icon: FaIcon(FontAwesomeIcons.youtube, color: Colors.red,size: 25)),
                  //     ],
                  //   ),
                  // ),
                  const SizedBox(height: 10),
                  // مواعيد العمل والراتب
                  widget.bus['salary']==0? const SizedBox():
                  Container(// height: 250,
                    width: MediaQuery.of(context).size.width *0.9,
                    decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(10)
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          ('الراتب:  ')+('${widget.bus['salary'].toString()}'),
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.indigo
                          ),),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  // العنوان
                  Container(
                    // height: 250,
                    width: MediaQuery.of(context).size.width *0.9,
                    decoration: BoxDecoration(
                        color: Colors.grey.shade200,
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
                          widget.bus['address'],
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

Widget reviews(var reviewsStream){
  return ExpandablePanel(
    header:const Padding(
      padding: EdgeInsets.all(10),
      child: Text('Reviews', style: TextStyle(
          color: Colors.blue,fontSize: 24, fontWeight: FontWeight.bold
      ),),
    ),
    collapsed: SizedBox(height: 230,child: reviewsAll(reviewsStream),),
    expanded: reviewsAll(reviewsStream),
  );
}

Widget reviewsAll(var reviewsStream){
  return StreamBuilder<QuerySnapshot>(
    stream: reviewsStream,
    builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot2) {

      if (snapshot2.connectionState == ConnectionState.waiting) {
        return const Center(child: CircularProgressIndicator(color: Colors.purple,),);
      }

      if(snapshot2.data!.docs.isEmpty){
        return const Center(child: Text('this Item \n\n has Reviews item yet ' ,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 26 , color: Colors.blueGrey,fontFamily:'Acme', letterSpacing: 1.5),) ,);
      }
      return ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: snapshot2.data!.docs.length,

          itemBuilder: (context, index){
            return ListTile(
              leading: CircleAvatar(
                backgroundImage: NetworkImage(snapshot2.data!.docs[index]['profileimage']),
              ),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(snapshot2.data!.docs[index]['name']),
                  Row(
                    children: [
                      Text(snapshot2.data!.docs[index]['rate'].toString()),
                      const Icon(Icons.star, color: Colors.amber,)
                    ],
                  )
                ],
              ),
              subtitle: Text(
                  snapshot2.data!.docs[index]['comment']
              ),
            ) ;
          }) ;
    },
  );
}
