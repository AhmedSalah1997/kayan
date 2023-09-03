// // ignore_for_file: avoid_print
//
// import 'dart:io';
//
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
// import 'package:path/path.dart' as path;
// import 'package:uuid/uuid.dart';
//
// import '../ulited/categ_list.dart';
// import '../widgets/snakebar.dart';
//
//
//
// class UploadEducation extends StatefulWidget {
//   const UploadEducation({Key? key}) : super(key: key);
//
//   @override
//   State<UploadEducation> createState() => _UploadEducationState();
// }
//
// final GlobalKey<ScaffoldMessengerState> _scaffoldKey =
// GlobalKey<ScaffoldMessengerState>();
//
// class _UploadEducationState extends State<UploadEducation> {
//   late int number2;
//   late int number1;
//   late int number3;
//   late int whats;
//   late String proName;
//   late String youtube;
//   late String prodesc;
//   late String address;
//   late String facebook;
//   late String instagram;
//   late String twitter;
//   late String linkedin;
//   late String proId;
//
//   String mainCategValue = 'select category';
//   String subCategValue = 'subcategory';
//
//   List<String> subCategList = [];
//
//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
//
//   final ImagePicker _picker = ImagePicker();
//   List<XFile>? imagesFlieList = [];
//   List<String> imagesUrlList = [];
//   dynamic _pickedImageError;
//   bool proeccing = false;
// // حجم الصورة
//   void _pickProductImages() async {
//     try {
//       final pickeImage = await _picker.pickMultiImage(
//           maxHeight: 300, maxWidth: 300, imageQuality: 95);
//       setState(() {
//         imagesFlieList = pickeImage;
//       });
//     } catch (e) {
//       setState(() {
//         _pickedImageError = e;
//       });
//       print(_pickedImageError);
//     }
//   }
// // عرض الصورة معاينة
//   Widget previewImages() {
//     if (imagesFlieList!.isNotEmpty) {
//       return InkWell(
//         onLongPress: () {
//           setState(() {
//             imagesFlieList = [];
//           });
//         },
//         child: ListView.builder(
//             itemCount: imagesFlieList!.length,
//             itemBuilder: (context, index) {
//               return Image.file(File(imagesFlieList![index].path));
//             }),
//       );
//     } else {
//       return const Center(
//         child: Text(
//           'you have not \n \n picked image yet !',
//           textAlign: TextAlign.center,
//           style: TextStyle(fontSize: 16),
//         ),
//       );
//     }
//   }
// // رفع كاتوجري
//   void selectedMainCateg (String ? value){
//     if (value == 'select category') {
//       subCategList = [];
//     }
//
//     else if (value == 'primarystage') {//
//       subCategList = primarystage;
//     }
//     else if (value == 'middleschool') {//
//       subCategList = middleschool;
//     }
//     else if (value == 'highschool') {//
//       subCategList = highschool;
//     }
//     else if (value == 'kindergarten') {//
//       subCategList = kindergarten;
//     }
//
//     print(value);
//     setState(() {
//       mainCategValue = value!;
//       subCategValue = 'subcategory';
//     });
//   }
// // رفع صورة
//   Future<void> uploadImage() async {
//     if (mainCategValue != 'select category' && subCategValue !='subcategory' ) {
//       if (_formKey.currentState!.validate()) {
//         _formKey.currentState!.save();
//         if (imagesFlieList!.isNotEmpty) {
//           setState(() {
//             proeccing = true;
//           });
//           try{
//             for(var image in imagesFlieList!){
//               firebase_storage.Reference ref = firebase_storage.FirebaseStorage.instance.ref(
//                   'products/${path.basename(image.path)}'
//               );
//               await ref.putFile(File(image.path)).whenComplete(() async{
//                 await ref.getDownloadURL().then((value) {
//                   imagesUrlList.add(value);
//                 });
//               })  ;
//             }
//           }catch(e)
//
//           {print(e);}
//
//
//         } else {
//           MyMassege.showSnakeBar(_scaffoldKey, 'please pick images first');
//         }
//       } else {
//         MyMassege.showSnakeBar(_scaffoldKey, 'please fill all field');
//       }
//     } else {
//       MyMassege.showSnakeBar(_scaffoldKey, 'select categories');
//     }
//   }
// // رفع البيانات على الفاير بيز
//   void uploadData()async{
//     if(imagesUrlList.isNotEmpty){
//       CollectionReference productRef = FirebaseFirestore.instance.collection('products');
//       proId = const Uuid().v4();
//       await productRef.doc(proId).set({
//         'proid': proId,
//         'maincateg': mainCategValue,
//         'subcateg': subCategValue,
//         'number1':number1,
//         'number2':number2,
//         'number3':number3,
//         'whats':whats,
//         'proname':proName,
//         'prodec': prodesc,
//         'address': address,
//         'facebook': facebook,
//         'instagram': instagram,
//         'twitter': twitter,
//         'linkedin': linkedin,
//         'youtube': youtube,
//         'sid':FirebaseAuth.instance.currentUser!.uid,
//         'proimage': imagesUrlList,
//
//       }).whenComplete(() {
//         setState(() {
//           proeccing = false;
//           imagesFlieList = [];
//           mainCategValue = 'select category';
//           subCategList = [];
//           imagesUrlList = [];
//         });
//         _formKey.currentState!.reset();
//       });
//     }else{
//       print('no images');
//     }
//   }
//
//   void uploadProduct()async{
//     await uploadImage().whenComplete(() =>uploadData());
//   }
//
//
//   @override
//   Widget build(BuildContext context) {
//     var size = MediaQuery.of(context).size ;
//     return ScaffoldMessenger(
//       key: _scaffoldKey,
//       child: Scaffold(
//         body: SafeArea(
//           child: SingleChildScrollView(
//             reverse: true,
//             keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
//             child: Form(
//               key: _formKey,
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.end,
//                 children: [
//                   // اختيار النشاط
//                   Row(
//                       children: [
//                         Container(
//                           color: Colors.blueGrey.shade100,
//                           height: size.width * 0.5,
//                           width: size.width * 0.5,
//                           child: imagesFlieList != null
//                               ? previewImages()
//                               : const Center(
//                             child: Text(
//                               'you have not \n \n picked image yet !',
//                               textAlign: TextAlign.center,
//                               style: TextStyle(fontSize: 16),
//                             ),
//                           ),
//                         ),
//                         SizedBox(
//                           height: size.width*.5,
//                           width: size.width*.5,
//                           child: Column(
//                             mainAxisAlignment: MainAxisAlignment.spaceAround,
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Column(
//                                 children: [
//                                   const Text('* select main category' ,
//                                     style: TextStyle(color: Colors.red),),
//                                   DropdownButton(
//                                     iconSize: 40,
//                                     iconEnabledColor: Colors.red,
//                                     dropdownColor: Colors.yellow.shade400,
//                                     value: mainCategValue,
//                                     items:maincateg
//                                         .map<DropdownMenuItem<String>>((value) {
//                                       return DropdownMenuItem(
//                                         value: value,
//                                         child: Text(value),
//                                       );
//                                     }).toList(),
//                                     onChanged: (String? value) {
//                                       selectedMainCateg(value);
//                                     },
//                                   ),
//                                 ],
//                               ),
//                               Column(
//                                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   const Text(
//                                     '* select subcategory ' , style: TextStyle(color: Colors.red),
//                                   ),
//                                   DropdownButton(
//                                     iconSize: 40,
//                                     iconDisabledColor: Colors.black,
//                                     iconEnabledColor: Colors.red,
//                                     dropdownColor: Colors.yellow.shade400,
//                                     disabledHint: const Text('select category'),
//                                     value: subCategValue,
//                                     items:subCategList
//                                         .map<DropdownMenuItem<String>>((value) {
//                                       return DropdownMenuItem(
//                                         value: value,
//                                         child: Text(value),
//                                       );
//                                     }).toList(),
//                                     onChanged: (String? value) {
//                                       print(value);
//                                       setState(() {
//                                         subCategValue = value!;
//                                       });
//                                     },
//                                   ),
//                                 ],
//                               ),
//                             ],
//                           ),
//                         )]
//                   ),
//                   const SizedBox(
//                     height: 5,
//                     child: Divider(
//                       color: Colors.black,
//                       thickness: .5,
//                     ),
//                   ),
//
//                   // رقم تواصل 1 , 2
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceAround,
//                     children: [
//                       SizedBox(
//                         width: MediaQuery.of(context).size.width * 0.45,
//                         child: TextFormField(
//                           validator: (value) {
//                             if (value!.isEmpty) {
//                               return ' رجاء ادخل رقم النشاط';
//                             }
//                             return null;
//                           },
//                           onSaved: (value) {
//                             number1 = int.parse(value!);
//                           },
//                           keyboardType: const TextInputType.numberWithOptions(
//                               decimal: true),
//                           decoration: textFormDecration.copyWith(
//                             labelText:'رقم نشاط1',
//                             hintText: '',
//                           ),
//                         ),
//                       ),
//                       SizedBox(
//                         width: MediaQuery.of(context).size.width * 0.45,
//                         child: TextFormField(
//                           validator: (value) {
//                             if (value!.isEmpty) {
//                               return ' رجاء ادخل رقم النشاط';
//                             }
//                             return null;
//                           },
//                           onSaved: (value) {
//                             number2 = int.parse(value!);
//                           },
//                           keyboardType: const TextInputType.numberWithOptions(
//                               decimal: true),
//                           decoration: textFormDecration.copyWith(
//                             labelText: 'رقم نشاط 2',
//                             hintText: '',
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                   const SizedBox(
//                     height: 5,
//                     child: Divider(
//                       color: Colors.black,
//                       thickness: .5,
//                     ),
//                   ),
//
//                   // رقم تواصل3 وواتس
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceAround,
//                     children: [
//                       SizedBox(
//                         width: MediaQuery.of(context).size.width * 0.45,
//                         child: TextFormField(
//                           validator: (value) {
//                             if (value!.isEmpty) {
//                               return ' رجاء ادخل رقم النشاط';
//                             }
//                             return null;
//                           },
//                           onSaved: (value) {
//                             number3 = int.parse(value!);
//                           },
//                           keyboardType: const TextInputType.numberWithOptions(
//                               decimal: true),
//                           decoration: textFormDecration.copyWith(
//                             labelText:'رقم نشاط3',
//                             hintText: '',
//                           ),
//                         ),
//                       ),
//                       SizedBox(
//                         width: MediaQuery.of(context).size.width * 0.45,
//                         child: TextFormField(
//                           validator: (value) {
//                             if (value!.isEmpty) {
//                               return ' رجاء ادخل رقم النشاط';
//                             }
//                             return null;
//                           },
//                           onSaved: (value) {
//                             whats = int.parse(value!);
//                           },
//                           keyboardType: const TextInputType.numberWithOptions(
//                               decimal: true),
//                           decoration: textFormDecration.copyWith(
//                             labelText: 'رقم واتس ',
//                             hintText: '',
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                   const SizedBox(
//                     height: 5,
//                     child: Divider(
//                       color: Colors.black,
//                       thickness: .5,
//                     ),
//                   ),
//                   // دليفري ولا لا
//                   const SizedBox(
//                     height: 5,
//                     child: Divider(
//                       color: Colors.black,
//                       thickness: .5,
//                     ),
//                   ),
//                   const SizedBox(
//                     height: 5,
//                     child: Divider(
//                       color: Colors.black,
//                       thickness: .5,
//                     ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: SizedBox(
//                       width: MediaQuery.of(context).size.width * 0.99,
//                       child: TextFormField(
//                         validator: (value) {
//                           if (value!.isEmpty) {
//                             return 'رجاء وصف النشاط';
//                           }
//                           return null;
//                         },
//                         onSaved: (value) {
//                           prodesc = (value!);
//                         },
//                         maxLength: 800,
//                         maxLines: 2,
//                         decoration: textFormDecration.copyWith(
//                           labelText: 'وصف النشاط ',
//                           hintText: '',
//                         ),
//                       ),
//                     ),
//                   ),
//                   // وصف النشاط
//                   const SizedBox(
//                     height: 5,
//                     child: Divider(
//                       color: Colors.black,
//                       thickness: .5,
//                     ),
//                   ),
//                   // اسم النشاط
//                   Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: SizedBox(
//                       width: MediaQuery.of(context).size.width * 0.99,
//                       child: TextFormField(
//                         validator: (value) {
//                           if (value!.isEmpty) {
//                             return 'رجاء اكتب اسم النشاط';
//                           }
//                           return null;
//                         },
//                         onSaved: (value) {
//                           proName = (value!);
//                         },
//                         maxLines: 1,
//                         decoration: textFormDecration.copyWith(
//                           labelText: 'اسم النشاط ',
//                           hintText: '',
//                         ),
//                       ),
//                     ),
//                   ),
//                   const SizedBox(
//                     height: 5,
//                     child: Divider(
//                       color: Colors.black,
//                       thickness: .5,
//                     ),
//                   ),
//                   // العنوان
//                   Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: SizedBox(
//                       width: MediaQuery.of(context).size.width * 0.99,
//                       child: TextFormField(
//                         validator: (value) {
//                           if (value!.isEmpty) {
//                             return 'رجاء ادخل العنوان';
//                           }
//                           return null;
//                         },
//                         onSaved: (value) {
//                           address = (value!);
//                         },
//                         maxLines: 1,
//                         decoration: textFormDecration.copyWith(
//                           labelText: 'عنوان النشاط',
//                           hintText: '',
//                         ),
//                       ),
//                     ),
//                   ),
//                   const SizedBox(
//                     height: 5,
//                     child: Divider(
//                       color: Colors.black,
//                       thickness: .5,
//                     ),
//                   ),
//                   // صفحه الفيس
//                   Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: SizedBox(
//                       width: MediaQuery.of(context).size.width * 0.99,
//                       child: TextFormField(
//                         onSaved: (value) {
//                           facebook = (value!);
//                         },
//                         maxLines: 2,
//                         decoration: textFormDecration.copyWith(
//                           labelText: 'صفحه فيس بوك',
//                           hintText: '',
//                         ),
//                       ),
//                     ),
//                   ),
//                   const SizedBox(
//                     height: 80,
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: SizedBox(
//                       width: MediaQuery.of(context).size.width * 0.99,
//                       child: TextFormField(
//                         onSaved: (value) {
//                           youtube = (value!);
//                         },
//                         maxLines: 2,
//                         decoration: textFormDecration.copyWith(
//                           labelText: 'يوتيوب',
//                           hintText: '',
//                         ),
//                       ),
//                     ),
//                   ),
//                   const SizedBox(
//                     height: 80,
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: SizedBox(
//                       width: MediaQuery.of(context).size.width * 0.99,
//                       child: TextFormField(
//                         onSaved: (value) {
//                           instagram = (value!);
//                         },
//                         maxLines: 2,
//                         decoration: textFormDecration.copyWith(
//                           labelText: 'انستجرام',
//                           hintText: '',
//                         ),
//                       ),
//                     ),
//                   ),
//                   const SizedBox(
//                     height: 80,
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: SizedBox(
//                       width: MediaQuery.of(context).size.width * 0.99,
//                       child: TextFormField(
//                         onSaved: (value) {
//                           linkedin = (value!);
//                         },
//                         maxLines: 2,
//                         decoration: textFormDecration.copyWith(
//                           labelText: 'لينكدان',
//                           hintText: '',
//                         ),
//                       ),
//                     ),
//                   ),
//                   const SizedBox(
//                     height: 80,
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: SizedBox(
//                       width: MediaQuery.of(context).size.width * 0.99,
//                       child: TextFormField(
//                         onSaved: (value) {
//                           twitter = (value!);
//                         },
//                         maxLines: 2,
//                         decoration: textFormDecration.copyWith(
//                           labelText: 'تويتر',
//                           hintText: '',
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//         floatingActionButton: Row(
//           mainAxisAlignment: MainAxisAlignment.start,
//           children: [
//             const SizedBox(width: 10,),
//             Padding(
//               padding: const EdgeInsets.only(left: 10),
//               child: FloatingActionButton(
//                 onPressed: proeccing == true
//                     ? null
//                     :() {
//                   uploadProduct();
//                 },
//                 backgroundColor: Colors.blueAccent,
//                 child:proeccing== true ?
//                 const CircularProgressIndicator(color: Colors.purple,):
//                 const Icon(
//                   Icons.upload,
//                   color: Colors.black,
//                 ),
//               ),
//             ),
//             const SizedBox(width: 10,),
//             FloatingActionButton(
//               onPressed: imagesFlieList!.isEmpty
//                   ? () {
//                 _pickProductImages();
//               }
//                   : () {
//                 setState(() {
//                   imagesFlieList = [];
//                 });
//               },
//               backgroundColor: Colors.blueAccent,
//               child: imagesFlieList!.isEmpty
//                   ? const Icon(
//                 Icons.photo_library,
//                 color: Colors.black,
//               )
//                   : const Icon(
//                 Icons.delete_forever,
//                 color: Colors.redAccent,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// var textFormDecration = InputDecoration(
//   labelText: 'price',
//   hintText: 'price..\$',
//   labelStyle: const TextStyle(color: Colors.purple),
//   border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
//   enabledBorder: OutlineInputBorder(
//     borderSide: const BorderSide(color: Colors.black54, width: 1),
//     borderRadius: BorderRadius.circular(10),
//   ),
//   focusedBorder: OutlineInputBorder(
//     borderSide: const BorderSide(color: Colors.black54, width: 1),
//     borderRadius: BorderRadius.circular(10),
//   ),
// );
//
