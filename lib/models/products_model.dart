
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../minor/edit_prouduct_screen.dart';
import '../minor/product_details.dart';


class ProductModel extends StatefulWidget {
  final dynamic product ;
  const ProductModel({
    Key? key,
    required this.product
  }) : super(key: key);

  @override
  State<ProductModel> createState() => _ProductModelState();
}

class _ProductModelState extends State<ProductModel> {

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>  ProductDetailsSecreen(proList: widget.product,)));
      },
      child: Padding(
        padding: const EdgeInsets.all(0.0),
        child: Center(
          child: Container(
            margin: EdgeInsets.all(10),
            height: MediaQuery.of(context).size.height *0.33,
            width: MediaQuery.of(context).size.width *0.78,
            decoration: BoxDecoration(color: Colors.white ,
              borderRadius: BorderRadius.circular(15),),
            child:Column(
              children: [
                Expanded(
                  flex: 1,
                  child: ClipRRect(
                    borderRadius: const BorderRadius.only(topLeft:Radius.circular(15),topRight:Radius.circular(15) ),
                    child: Container(
                      padding: EdgeInsets.only(top: 10),
                      child: Image(image: NetworkImage(widget.product['proimage'][1]),
                        fit: BoxFit.contain,
                        height: double.infinity,
                        width: double.infinity,
                      ),),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Text(widget.product['proname'],
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontSize: 16 , fontWeight: FontWeight.w600, color: Colors.indigo),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            flex:1,
                            child: Text(widget.product['address'],
                              maxLines: 1,
                              textAlign: TextAlign.center,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle( fontSize: 13 , fontWeight: FontWeight.w200, ),
                            ),
                          ),
                          // const SizedBox(width: 10,),
                          // Expanded(
                          //   flex: 1,
                          //     child: Icon(Icons.location_on,size: 17,color: Colors.indigo,))
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          widget.product['sid']== FirebaseAuth.instance.currentUser!.uid
                              ?
                          IconButton(
                              onPressed: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context){
                                  return  EditProduct(items: widget.product,);
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