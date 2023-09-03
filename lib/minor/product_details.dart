
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:full_screen_image_null_safe/full_screen_image_null_safe.dart';
import 'package:url_launcher/url_launcher.dart';
import '../man_screen/delevery.dart';
import 'appbarwidget.dart';


class ProductDetailsSecreen extends StatefulWidget {
  final dynamic proList;

  const ProductDetailsSecreen({Key? key, required this.proList})
      : super(key: key);

  @override
  State<ProductDetailsSecreen> createState() => _ProductDetailsSecreenState();
}

class _ProductDetailsSecreenState extends State<ProductDetailsSecreen> {

  editProductData()async{
    await FirebaseFirestore.instance.runTransaction((transaction)async {
      DocumentReference documentReference = FirebaseFirestore.instance.collection('products')
          .doc(widget.proList['proid']);
      transaction.update(documentReference, {
        'total': 2,
      });
    }).whenComplete(() => Navigator.pop(context));
  }


  late List<dynamic> imagesList = widget.proList['proimage'];

  void _opewhatsApp()async{
    String phoneNumber = '20${widget.proList['whats'].toString()}' ;
    var url = 'http://wa.me/$phoneNumber?text=HelloWorld';
    editProductData();
    await launch(url);
  }

  @override
  Widget build(BuildContext context) {

  final Uri url = Uri.parse(widget.proList['facebook']);
  final Uri instgram = Uri.parse(widget.proList['instgram']);
  final Uri youtube = Uri.parse(widget.proList['youtube']);


    return Material(
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.grey[100],
            centerTitle: true ,
            title:
            Text(widget.proList['proname'], style: TextStyle(color: Colors.black),
            ),
            leading: AppBarBackButton(),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(left: 10,right: 15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // صورة واسم ونوع النشاط
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18.0),
                    child: ClipRRect(
                      borderRadius:  BorderRadius.circular(15),
                      child: Image.network(widget.proList['proimage'][1],
                        height: MediaQuery.of(context).size.height*.3,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
// الاسم بتاع النشاط والوصف
                  const SizedBox(height: 20),

                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(10)
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(height: 10,),
                        Text(
                          widget.proList['proname'],
                          style: const TextStyle(
                              color: Colors.indigo,
                              fontSize: 18,
                              fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(height: 2,),
                        Text(
                          widget.proList['prodec'],
                          style: const TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),

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

                  const SizedBox(height: 10,),
                  // ارقام الاتصال والاستفسار

                  Container(
                    decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(10)
                    ),
                    child: Column(
                      children: [
                        const SizedBox(height: 10,),
                        // ايقون الاتصال1
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.call,size: 20,color: Colors.indigo,),
                            const SizedBox(width: 5,),
                            Text(
                                ('   0${widget.proList['number1'].toString()}') ,
                              style: const TextStyle(
                                  color: Colors.indigo,
                                  letterSpacing: 1.5,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                        const SizedBox(height: 5,),
                        // اتصال 2
                        widget.proList['number2'] == 0
                            ? const SizedBox(height: 0,)
                            : Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.call, color: Colors.indigo,size: 20,),
                            const SizedBox(width: 5,),
                            Text(
                              ('   0${widget.proList['number2'].toString()}') ,
                              style: const TextStyle(
                                  color: Colors.indigo,
                                  letterSpacing: 1.5,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                        const SizedBox(height: 5,),
                        // اتصال 3
                        widget.proList['number3'] == 0
                            ? const SizedBox()
                        :Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.call,color: Colors.indigo,size: 20,),
                            const SizedBox(width: 5,),
                            Text(
                              ('   0${widget.proList['number3'].toString()}') ,
                              style: const TextStyle(
                                  color: Colors.indigo,
                                  letterSpacing: 1.5,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                        const SizedBox(height: 5,),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  // الايقونات

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
                                  path: '0${widget.proList['number1'].toString()}'
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
                          launchUrl(url);
                        },
                            icon: FaIcon(FontAwesomeIcons.facebook, color: Colors.blue,size: 27)),
                        // insgram
                        IconButton(onPressed: (){
                          launchUrl(instgram);
                        },
                            icon: FaIcon(FontAwesomeIcons.instagram, color: Colors.indigo,size: 27)),
                        //youtube
                        IconButton(onPressed: (){
                          launchUrl(youtube);
                        },
                            icon: FaIcon(FontAwesomeIcons.youtube, color: Colors.red,size: 27)),

                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  // مواعيد العمل
                  widget.proList['startwork']=='0'? const SizedBox():
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(10)
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text(' مواعيد العمل الرسمية ',style: TextStyle(
                            fontSize: 18,
                            color: Colors.indigo
                        ),),
                        const SizedBox(height: 2,),
                        Text(
                          (' من الساعه ')
                              + ('${ widget.proList['startwork']}')
                              + ('  حتي ')
                              +('${ widget.proList['endwork']}  '),
                          style: const TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                              fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  // العنوان
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(10)
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text(' العنوان ',style: TextStyle(
                            fontSize: 18,
                            color: Colors.indigo
                        ),),
                        const SizedBox(height: 2,),
                        Text(
                          widget.proList['address'],
                          style: const TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                              fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                // خدمة الدليفري

                  widget.proList['isdelvery']=='yes'
                      ?
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                            height: 100,
                            width: 100,
                            child: Image.asset('images/appicon/de.jpg', fit: BoxFit.cover,)),
                         Text(
                          '0${widget.proList['delevery'].toString()}' ,
                          style: TextStyle(
                            fontSize: 25,
                            color: Colors.blue
                        ),),
                      ],
                    ),
                  )
                  :InkWell(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context){
                        return Delevrey();
                      }));
                    },
                    child: Container(
                      height: 200,
                      decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(10)
                      ),
                      child:  Image.asset('images/appicon/de2.jpg', fit: BoxFit.cover,),
                    ),
                  ),
                  const SizedBox(height: 20),
                  // اسم ووصف الشركه وارقام الاتصال والمجال
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}




