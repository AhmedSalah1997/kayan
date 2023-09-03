import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../minor/appbarwidget.dart';

class AbhasHome extends StatefulWidget {
  const AbhasHome({Key? key}) : super(key: key);

  @override
  State<AbhasHome> createState() => _AbhasHomeState();
}


class _AbhasHomeState extends State<AbhasHome> {

  final Uri facebook = Uri.parse('https://www.facebook.com/profile.php?id=100070243890807');
  final Uri youtube = Uri.parse('');

  void _opewhatsApp()async{
    String phoneNumber = '20 109 064 3343' ;
    var url = 'http://wa.me/$phoneNumber?text=HelloWorld';
    await launch(url);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.grey[300],
        leading: AppBarBackButton(),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('تقدم شركة كيان هذه الخدمة وذلك عن طريق التواصل مع الشركه لاستكمال الخدمة',
            textAlign:TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 21,),
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
      ),
    );
  }
}
