
import 'package:flutter/material.dart';
import 'package:kyan/find_jop/products_jop.dart';





class ShowJop extends StatefulWidget {
  final dynamic showjop ;
  const ShowJop({
    Key? key,
    required this.showjop
  }) : super(key: key);

  @override
  State<ShowJop> createState() => _ShowJopState();
}

class _ShowJopState extends State<ShowJop> {

  @override
  Widget build(BuildContext context) {
    // var onSale =widget.product['discount'];
    return InkWell(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>  ProductJopSecreen(jop: widget.showjop,)));
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child:
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(0),
                    color: Colors.white
                  ),
                  height: MediaQuery.of(context).size.height*.17,
                  width: MediaQuery.of(context).size.width*.9,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      ElevatedButton(onPressed: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>  ProductJopSecreen(jop: widget.showjop,)));
                      },
                          child: Text('التفاصيل',style: TextStyle(fontSize: 12,color: Colors.white))
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(widget.showjop['text'],style: TextStyle(fontSize: 15,fontWeight: FontWeight.w900),),
                          Text('${widget.showjop['salary'].toString()}',style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400,color: Colors.indigo),),
                        ],
                      ),
                      // const SizedBox(width: 15,),
                      Image(image: NetworkImage(
                        widget.showjop['proimage'][0]),fit: BoxFit.fill,
                      height: MediaQuery.of(context).size.height*.15,
                      width: MediaQuery.of(context).size.width*.3,
                      )
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