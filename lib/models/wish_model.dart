//
//
// import 'package:collection/collection.dart';
// import 'package:dened/provides/cart_provides.dart';
// import 'package:dened/provides/product_class.dart';
// import 'package:dened/provides/wish_provider.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
//
//
// class WishListModel extends StatelessWidget {
//   const WishListModel({
//     Key? key,
//     required this.product,
//   }) : super(key: key);
//
//   final Product product;
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(6.0),
//       child: Column(
//         mainAxisAlignment:
//         MainAxisAlignment.spaceBetween,
//         children: [
//           Text(
//             product.name,
//             maxLines: 2,
//             overflow: TextOverflow.ellipsis,
//             style: TextStyle(
//                 fontSize: 16,
//                 fontWeight: FontWeight.w600,
//                 color: Colors.grey.shade700),
//           ),
//           Row(
//             mainAxisAlignment:
//             MainAxisAlignment
//                 .spaceBetween,
//             children: [
//               Text(
//                 product.number
//                     .toStringAsFixed(2),
//                 style: const TextStyle(
//                     fontSize: 16,
//                     fontWeight:
//                     FontWeight.bold,
//                     color: Colors.red),
//               ),
//               Row(children: [
//                 IconButton(onPressed: (){
//                   context.read<Wish>().removeItemWish(product);
//                 },
//                     icon:const Icon(Icons.delete_forever)
//                 ),
//                 const SizedBox(width: 10,),
//                 context.watch<Cart>().getItems.firstWhereOrNull(
//                         (elment) =>
//                         elment.documentId ==
//                         product.documentId) !=
//                     ?  const SizedBox()
//                     :  IconButton(onPressed: (){
//                   context.read<Cart>().addItem(
//                     Product(
//                         documentId:product.documentId,
//                         name: product.name,
//                         number:product.number,
//                         // qty: 1,
//                         // qntty: product.qntty,
//                         imagesUrl: product.imagesUrl,
//                         suppId:  product.suppId
//                     ),
//                   );
//                 },
//                     icon:const Icon(Icons.add_shopping_cart)
//                 )
//               ],)
//             ],
//           )
//         ],
//       ),
//     );
//   }
// }