
import 'package:flutter/material.dart';



class ShowLowSchool extends StatefulWidget {
  final dynamic showLowSchool ;
  const ShowLowSchool({
    Key? key,
    required this.showLowSchool
  }) : super(key: key);

  @override
  State<ShowLowSchool> createState() => _ShowLowSchoolState();
}

class _ShowLowSchoolState extends State<ShowLowSchool> {

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
                    Expanded(
                      flex: 1,
                      child: Container(
                          child: Image.network(widget.showLowSchool['image'],fit: BoxFit.fill,)
                      ),
                    ),
                    const SizedBox(height: 9,),
                    Text(widget.showLowSchool['name'],style: TextStyle(fontSize: 18),),
                    Text('العنوان:   ${widget.showLowSchool['address']}',style: TextStyle(fontSize: 15),),
                    Text('رقم التواصل:   0${widget.showLowSchool['number'].toString()}',style: TextStyle(fontSize: 15),),
                  ],
                ),
              )
            ],
          ),
        )
    );
  }
}