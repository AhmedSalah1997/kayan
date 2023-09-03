
import 'package:flutter/material.dart';



class ShowSchool extends StatefulWidget {
  final dynamic showSchool ;
  const ShowSchool({
    Key? key,
    required this.showSchool
  }) : super(key: key);

  @override
  State<ShowSchool> createState() => _ShowSchoolState();
}

class _ShowSchoolState extends State<ShowSchool> {

  @override
  Widget build(BuildContext context) {
    // var onSale =widget.product['discount'];
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child:
        Center(
          child: Column(
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
                          child: Image.network(widget.showSchool['image'],fit: BoxFit.fill,)
                      ),
                    ),
                    const SizedBox(height: 9,),
                    Text(widget.showSchool['name'],style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                    Text('العنوان:   ${widget.showSchool['address']}',style: TextStyle(fontSize: 15),),
                    Text(' المصاريف السنوية:   ${widget.showSchool['salary'].toString()}',style: TextStyle(fontSize: 15),),
                    Text('رقم التواصل:   0${widget.showSchool['number'].toString()}',style: TextStyle(fontSize: 15),),
                  ],
                ),
              )
            ],
          ),
        )
    );
  }
}