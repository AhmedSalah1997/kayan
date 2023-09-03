import 'package:flutter/material.dart';

import '../man_screen/upload_prodouct.dart';
import '../slider/uploadslider.dart';

class UpLoadeDataToApp extends StatefulWidget {
  const UpLoadeDataToApp({Key? key}) : super(key: key);

  @override
  State<UpLoadeDataToApp> createState() => _UpLoadeDataToAppState();
}

class _UpLoadeDataToAppState extends State<UpLoadeDataToApp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('UpLoad'),
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              InkWell(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return UploadSliderScreen();
                  }));
                },
                child: Container(
                  height: 50,
                  width: 100,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.indigo),
                  child: Text(
                    ' رفع اعلان ',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return UploadProdouctScreen();
                  }));
                },
                child: Container(
                  height: 50,
                  width: 100,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.indigo),
                  child: Text(
                    ' رفع نشاط ',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceAround,
          //   children: [
          //     InkWell(
          //       onTap: (){
          //         Navigator.push(context, MaterialPageRoute(builder: (context){
          //           return  UploadEducation();
          //         })) ;
          //       },
          //       child: Container(
          //         height: 50,
          //         width: 100,
          //         decoration: BoxDecoration(
          //           borderRadius: BorderRadius.circular(15),
          //           color: Colors.indigo
          //         ),
          //         child: Text(' رفع نشاط معلم ', style: TextStyle(
          //           color: Colors.white,
          //           fontSize: 25,
          //         ),),
          //       ),
          //     ),
          //
          //   ],
          // ),
        ],
      ),
    );
  }
}
