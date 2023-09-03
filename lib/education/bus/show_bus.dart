
import 'package:flutter/material.dart';
import 'package:full_screen_image_null_safe/full_screen_image_null_safe.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';


class ShowBus extends StatefulWidget {
  final dynamic showBus ;
  const ShowBus({
    Key? key,
    required this.showBus
  }) : super(key: key);

  @override
  State<ShowBus> createState() => _ShowBusState();
}

class _ShowBusState extends State<ShowBus> {



  @override
  Widget build(BuildContext context) {

    void _opewhatsApp()async{
      String phoneNumber = '20${widget.showBus['whats'].toString()}' ;
      var url = 'http://wa.me/$phoneNumber?text=HelloWorld';
      await launch(url);
    }
    final Uri facebook = Uri.parse(widget.showBus['facebook']);
    final Uri youtube = Uri.parse(widget.showBus['youtube']);

    // var onSale =widget.product['discount'];
    return InkWell(
      onTap: (){
      },
      child: Padding(
          padding: const EdgeInsets.all(8.0),
          child:
          Center(
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.white
                  ),
                  height: MediaQuery.of(context).size.height*.4,
                  width: MediaQuery.of(context).size.width*.9,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child:FullScreenWidget(child: Image.network(widget.showBus['image'],height: MediaQuery.of(context).size.height*.3,)),
                     flex: 1,
                      ),
                      Text(widget.showBus['name'],style: TextStyle(fontSize: 18),),
                     Row(
                       mainAxisAlignment: MainAxisAlignment.spaceAround,
                       children: [
                         Text(widget.showBus['address'],style: TextStyle(fontSize: 15),),
                         // const SizedBox(width: 5,),
                         Text('0${widget.showBus['number'].toString()}',style: TextStyle(fontSize: 15),),
                       ],
                     ),
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
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
                )
              ],
            ),
          )
      ),
    );
  }
}