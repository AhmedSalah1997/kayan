
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../minor/appbarwidget.dart';



class ProductSchoolSecreen extends StatefulWidget {
  final dynamic school;

  const ProductSchoolSecreen({Key? key, required this.school})
      : super(key: key);

  @override
  State<ProductSchoolSecreen> createState() => _ProductSchoolSecreenState();
}

class _ProductSchoolSecreenState extends State<ProductSchoolSecreen> {

  final GlobalKey<ScaffoldMessengerState> _scaffoldKey =
  GlobalKey<ScaffoldMessengerState>();



  void _opewhatsApp()async{
    String phoneNumber = '20${widget.school['whats'].toString()}' ;
    var url = 'http://wa.me/$phoneNumber?text=HelloWorld';
    await launch(url);
  }

  @override
  Widget build(BuildContext context) {
    final Uri url2 = Uri.parse(widget.school['facebook']);
    final Uri url3 = Uri.parse(widget.school['youtube']);
    final Uri url = Uri(scheme: 'tel', path: '0${widget.school['number'].toString()}');


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
              title: Text(widget.school['name'], style: TextStyle(color: Colors.black),),
              leading: AppBarBackButton(),
            ),
            body: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // صورة واسم ونوع النشاط
                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 18.0),
                      child: ClipRRect(
                        borderRadius:  BorderRadius.circular(15),
                        child: Container(
                            constraints:const BoxConstraints(minHeight: 150, maxHeight: 200,),
                            child: Image(
                              image: NetworkImage(widget.school['image']),fit: BoxFit.cover,)
                        ),
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
                              widget.school['name'],
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
                        widget.school['number'] == 0
                            ? const SizedBox(height: 0,)
                            : Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.call,size: 25,),
                            const SizedBox(width: 5,),
                            Text(
                              ('   0${widget.school['number'].toString()}') ,
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
                  // مواعيد العمل والراتب
                  widget.school['salary']==0? const SizedBox():
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
                          ('الراتب:  ')+('${widget.school['salary'].toString()}'),
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
                          widget.school['address'],
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


