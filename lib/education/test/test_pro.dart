
import 'package:flutter/material.dart';
import 'package:full_screen_image_null_safe/full_screen_image_null_safe.dart';



class TestPro extends StatefulWidget {
  final dynamic testPro ;
  const TestPro({
    Key? key,
    required this.testPro
  }) : super(key: key);

  @override
  State<TestPro> createState() => _TestProState();
}

class _TestProState extends State<TestPro> {

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child:
        Center(
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                decoration: BoxDecoration(
                    color: Colors.white
                ),
                height: MediaQuery.of(context).size.height*.5,
                width: MediaQuery.of(context).size.width*.85,
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(widget.testPro['label'],style: TextStyle(fontSize: 18),),
                    Expanded(
                      flex: 1,
                      child: FullScreenWidget(
                        child: Container(
                            child: Image.network(widget.testPro['image'],fit: BoxFit.contain,)
                        ),
                      ),
                    ),
                    const SizedBox(height: 9,),
                  ],
                ),
              )
            ],
          ),
        )
    );
  }
}