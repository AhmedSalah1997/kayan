



import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../minor/edit_prouduct_screen.dart';
import '../minor/product_details.dart';



class ShowEducation extends StatefulWidget {
  final dynamic education ;
  const ShowEducation({
    Key? key,
    required this.education
  }) : super(key: key);

  @override
  State<ShowEducation> createState() => _ShowEducationState();
}

class _ShowEducationState extends State<ShowEducation> {

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>  ProductDetailsSecreen(proList: widget.education,)));
      },
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Center(
          child: Container(
            height: MediaQuery.of(context).size.height *0.33,
            width: MediaQuery.of(context).size.width *0.7,
            decoration: BoxDecoration(color: Colors.white ,
              borderRadius: BorderRadius.circular(15),),
            child:Column(
              children: [
                Expanded(
                  flex: 1,
                  child: ClipRRect(
                    borderRadius: const BorderRadius.only(topLeft:Radius.circular(15),topRight:Radius.circular(15) ),
                    child:
                    Container(
                      width: double.infinity,
                      child: Image(
                        image: NetworkImage(widget.education['proimage'][1]),fit: BoxFit.contain ,
                        height: double.infinity,
                        width: double.infinity,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Text(widget.education['proname'],
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontSize: 14 , color: Colors.indigo ,fontWeight: FontWeight.w600),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(widget.education['address'],
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle( fontSize: 13 , fontWeight: FontWeight.w200,),
                          ),
                          const SizedBox(width: 10,),
                          Icon(Icons.location_on,size: 18,color: Colors.indigo,)
                        ],
                      ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          widget.education['sid']== FirebaseAuth.instance.currentUser!.uid?
                          IconButton(
                              onPressed: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context){
                                  return  EditProduct(items: widget.education,);
                                }));
                              },
                              icon:const Icon(Icons.edit, color: Colors.red,))
                              : const SizedBox(),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ) ,
          ),
        ),
      ),
    );
  }
}