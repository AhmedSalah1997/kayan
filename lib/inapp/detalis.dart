
import 'package:flutter/material.dart';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:full_screen_image_null_safe/full_screen_image_null_safe.dart';
import 'package:url_launcher/url_launcher.dart';
import '../minor/appbarwidget.dart';


class PayDetailsSecreen extends StatefulWidget {
  final dynamic pay;

  const PayDetailsSecreen({Key? key, required this.pay})
      : super(key: key);

  @override
  State<PayDetailsSecreen> createState() => _PayDetailsSecreenState();
}

class _PayDetailsSecreenState extends State<PayDetailsSecreen> {

  late List<dynamic> imagesList = widget.pay['teimages'];

  void _opewhatsApp()async{
    String phoneNumber = '20${widget.pay['whats'].toString()}' ;
    var url = 'http://wa.me/$phoneNumber?text=HelloWorld';
    await launch(url);
  }

  @override
  Widget build(BuildContext context) {

    final Uri url = Uri.parse(widget.pay['facebook']);
    final Uri instgram = Uri.parse(widget.pay['instgram']);
    final Uri youtube = Uri.parse(widget.pay['youtube']);

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.grey[100],
          centerTitle: true ,
          title:
          Text(widget.pay['text'], style: TextStyle(color: Colors.black),
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
                    child: Image.network(widget.pay['image'],
                      height: MediaQuery.of(context).size.height*.3,
                      // width: MediaQuery.of(context).size.width*.3,
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
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const SizedBox(height: 10,),
                          Text(
                            widget.pay['text'],
                            style: const TextStyle(
                                color: Colors.indigo,
                                fontSize: 18,
                                fontWeight: FontWeight.w600),
                          ),
                          const SizedBox(height: 2,),
                          Text(
                            widget.pay['decs'],
                            style: const TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.w600),
                          ),
                        ],
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
                            ('   0${widget.pay['number'].toString()}') ,
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
                                    path: '0${widget.pay['number'].toString()}'
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
                // العنوان
                Container(
                  // height: 250,
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
                        widget.pay['address'],
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



