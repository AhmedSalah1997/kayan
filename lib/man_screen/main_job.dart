import 'package:flutter/material.dart';
import 'package:kyan/minor/appbarwidget.dart';

import '../find_jop/find_jop1.dart';
import '../minor/morerent.dart';
import 'home_for_enput.dart';
import 'inputegar.dart';

class MainJobEgar extends StatefulWidget {
  const MainJobEgar({Key? key}) : super(key: key);

  @override
  State<MainJobEgar> createState() => _MainJobEgarState();
}

class _MainJobEgarState extends State<MainJobEgar> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: AppBarTitle(title: 'وظائف وإيجارات',),
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.grey[200],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 25.0, right: 10,left: 10),
          child: Center(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    InkWell(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context){
                          return FindJop();
                        }));
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.white,
                        ),
                        height: MediaQuery.of(context).size.height*.2,
                        width:  MediaQuery.of(context).size.height*.18,
                        child: Column(
                          children: [
                            Expanded(
                              flex:1,
                              child: Image.asset('images/all/call/t.png'),
                            ),
                            const Text('الوظائف',style: TextStyle(fontWeight: FontWeight.bold),),
                          ],
                        ),
                      ),

                    ),
                    InkWell(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context){
                          return EnputEgar();
                        }));
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.white,
                        ),
                        height: MediaQuery.of(context).size.height*.2,
                        width:  MediaQuery.of(context).size.height*.18,
                        child: Column(
                          children: [
                            Expanded(
                              flex:1,
                              child: Image.asset('images/all/call/t.png'),
                            ),
                            const Text('محلات للإيجار',style: TextStyle(fontWeight: FontWeight.bold),),
                          ],
                        ),
                      ),

                    ),

                  ],
                ),
                const SizedBox(height: 30,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    InkWell(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context){
                          return HomeRent();
                        }));
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.white,
                        ),
                        height: MediaQuery.of(context).size.height*.2,
                        width:  MediaQuery.of(context).size.height*.18,
                        child: Column(
                          children: [
                            Expanded(
                              flex:1,
                              child: Image.asset('images/all/call/t.png'),
                            ),
                            const Text('شقق للإيجار',style: TextStyle(fontWeight: FontWeight.bold),),
                          ],
                        ),
                      ),

                    ),
                    InkWell(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context){
                          return MoreRent();
                        }));
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.white,
                        ),
                        height: MediaQuery.of(context).size.height*.2,
                        width:  MediaQuery.of(context).size.height*.18,
                        child: Column(
                          children: [
                            Expanded(
                              flex:1,
                              child: Image.asset('images/all/out3/out5.png'),
                            ),
                            const Text('المزيد',style: TextStyle(fontWeight: FontWeight.bold),),
                          ],
                        ),
                      ),

                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
