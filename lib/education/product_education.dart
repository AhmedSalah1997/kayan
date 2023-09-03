
import 'package:flutter/material.dart';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import '../minor/appbarwidget.dart';


class ProductEducationSecreen extends StatefulWidget {
  final dynamic educatin;

  const ProductEducationSecreen({Key? key, required this.educatin})
      : super(key: key);

  @override
  State<ProductEducationSecreen> createState() => _ProductEducationSecreenState();
}

class _ProductEducationSecreenState extends State<ProductEducationSecreen> {

  final GlobalKey<ScaffoldMessengerState> _scaffoldKey =
  GlobalKey<ScaffoldMessengerState>();

  late List<dynamic> imagesList = widget.educatin['proimage'];

  void _opewhatsApp()async{
    String phoneNumber = '20${widget.educatin['whats'].toString()}' ;
    var url = 'http://wa.me/$phoneNumber?text=HelloWorld';
    await launch(url);
  }

  @override
  Widget build(BuildContext context) {
    final Uri facebook = Uri.parse(widget.educatin['facebook']);
    final Uri youtube = Uri.parse(widget.educatin['youtube']);
    final Uri instagram = Uri.parse(widget.educatin['instagram']);
    final Uri twitter = Uri.parse(widget.educatin['twitter']);
    final Uri linkedin = Uri.parse(widget.educatin['linkedin']);
    final Uri url = Uri(scheme: 'tel', path: '0${widget.educatin['number1'].toString()}');


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
              title: Text(widget.educatin['proname'], style: TextStyle(color: Colors.black),),
              leading: AppBarBackButton(),
            ),
            body: SingleChildScrollView(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // صورة واسم ونوع النشاط
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical:  7.0),
                      child: ClipRRect(
                        borderRadius:  BorderRadius.circular(15),
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.6,
                          constraints:const BoxConstraints(minHeight: 150, maxHeight: 230,),
                          child: Swiper(
                            itemBuilder: (context, index) {
                              return Image(
                                image: NetworkImage(imagesList[index]),fit: BoxFit.cover,);
                            },
                            itemCount: imagesList.length,
                          ),
                        ),
                      ),
                    ),
                    // اسم المعلم
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
                              const SizedBox(height: 10,),
                              Text(
                                widget.educatin['proname'],
                                style: const TextStyle(
                                    color: Colors.indigo,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600),
                              ),
                              const SizedBox(height: 2,),
                              Text(
                                widget.educatin['prodec'],
                                style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    // ارقام الاتصال والاستفسار
                    Container(color: Colors.green,
                        width: MediaQuery.of(context).size.width * .9,
                        height: MediaQuery.of(context).size.height * .8,
                        child: Image(
                            image: NetworkImage(widget.educatin['proimage'][1]),
                          height: double.infinity )
                    ),
                    const SizedBox(height: 10,),
                    Container(
                      // height: 250,
                      padding: EdgeInsets.all(8.0),
                      width: MediaQuery.of(context).size.width *0.9,
                      decoration: BoxDecoration(
                          color: Colors.grey[100],
                          borderRadius: BorderRadius.circular(10)
                      ),
                      child: Column(
                        children: [
                          // اتصال
                          widget.educatin['number1'] == 0
                              ? const SizedBox(height: 0,)
                              : Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.call,color: Colors.indigo,),
                              const SizedBox(width: 2,),
                              Text(
                                ('   0${widget.educatin['number1'].toString()}') ,
                                style: const TextStyle(
                                    color: Colors.indigo,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10,),
                    // الايقونات
                    Container(
                      width: MediaQuery.of(context).size.width *0.9,
                      decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(10)
                      ),
                      // الايقونات
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          // الواتس اب
                          widget.educatin['whats']==0? const SizedBox():  IconButton(onPressed: (){
                            _opewhatsApp();
                          },
                              icon: FaIcon(FontAwesomeIcons.whatsapp), color: Colors.green,iconSize: 27),
                          // الاتصال
                          widget.educatin['number1']==0? const SizedBox():  IconButton(onPressed: ()async{
                            if(await canLaunchUrl(url)){
                              await launchUrl(url);
                            }else {
                              print('مفيش رقم');
                            }
                            await launchUrl(url);
                          },
                              icon: Icon(Icons.call, color: Colors.indigo,size: 27)),
                          // google
                          widget.educatin['facebook']==''? const SizedBox():  IconButton(onPressed: (){
                            launchUrl(facebook);
                          },
                              icon: FaIcon(FontAwesomeIcons.facebook, color: Colors.indigo,size: 27)),
                          // facebook
                          widget.educatin['youtube']==''? const SizedBox():  IconButton(onPressed: (){
                            launchUrl(youtube);
                          },
                              icon: FaIcon(FontAwesomeIcons.youtube, color: Colors.red,size: 27)),
                        ],
                      ),
                    ),
                    const SizedBox(height: 5,),
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
                    //       // instgram
                    //       widget.educatin['instagram']==''? const SizedBox():   IconButton(onPressed: (){
                    //         launchUrl(instagram);
                    //       },
                    //           icon: FaIcon(FontAwesomeIcons.instagram), color: Colors.purple,iconSize: 27),
                    //       // twitter
                    //       widget.educatin['twitter']==''? const SizedBox(): IconButton(onPressed: ()async{
                    //         launchUrl(twitter);
                    //       },
                    //           icon: FaIcon(FontAwesomeIcons.twitter), color: Colors.indigo,iconSize: 27),
                    //       // linkin
                    //       widget.educatin['linkedin']==''? const SizedBox(): IconButton(onPressed: (){
                    //         launchUrl(linkedin);
                    //       },
                    //           icon: FaIcon(FontAwesomeIcons.linkedin, color: Colors.indigo,size: 27)),
                    //     ],
                    //   ),
                    // ),
                    const SizedBox(height: 5,),
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
                              Text(
                                'العنوان',
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600),
                              ),
                              Text(
                                widget.educatin['address'],
                                style: const TextStyle(
                                    color: Colors.indigo,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600),
                              ),
                              const SizedBox(height: 2,),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10,),
                  ],
                ),
              )
            ),
          ),
        ),
      ),
    );
  }
}


// class ContauneerMeting extends StatelessWidget {
//
//   final String elsaf;
//   final String elmarhala;
//   final String elmada;
//   final String timeout;
//   final String timeon;
//   final String place;
//
//   const ContauneerMeting({
//     Key? key,
//     required this.elsaf,
//     required this.elmarhala,
//     required this.elmada,
//     required this.timeout,
//     required this.timeon,
//     required this.place,
//
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: EdgeInsets.symmetric(vertical: 10),
//       height: MediaQuery.of(context).size.height*0.2,
//       width: MediaQuery.of(context).size.width *0.9,
//       decoration: BoxDecoration(
//           color: Colors.grey[100],
//           borderRadius: BorderRadius.circular(10)
//       ),
//       child: Column(
//           mainAxisAlignment: MainAxisAlignment.spaceAround ,
//           children:[
//             Row(
//               children: [
//                 Text(
//                   ('الصف الدراسي:  ')+ (elsaf),
//                   style: TextStyle(fontSize: 18, color: Colors.black),
//                 ),
//                 Text(
//                   ('المرحلة :  ')+ (elmarhala),
//                   style: TextStyle(fontSize: 18, color: Colors.black),
//                 ),
//               ],
//               mainAxisAlignment: MainAxisAlignment.spaceAround,
//             ),
//             Row(
//               children: [
//                 Text(
//                   ('اسم المادة :   ')+ (elmada),
//                   style: TextStyle(fontSize: 18, color: Colors.black),
//                 ),
//               ],
//               mainAxisAlignment: MainAxisAlignment.center,
//             ),
//             Row(
//               children: [
//                 Text(
//                   ('حتي الساعه :  ')+ (timeout),
//                   style: TextStyle(fontSize: 18, color: Colors.black),
//                 ),
//                 Text(
//                   (' من الساعه :  ')+ (timeon),
//                   style: TextStyle(fontSize: 18, color: Colors.black),
//                 ),
//               ],
//               mainAxisAlignment: MainAxisAlignment.spaceAround,
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Text(
//                   ('المكان:   ')+ (place),
//                   style: TextStyle(fontSize: 18, color: Colors.black),
//                 ),
//               ],
//             ),
//           ]
//       ),
//     );
//   }
// }
