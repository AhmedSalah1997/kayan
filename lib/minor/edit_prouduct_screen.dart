import 'dart:io';


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:path/path.dart' as path;

import '../ulited/categ_list.dart';
import '../widgets/button.dart';
import '../widgets/pick_button.dart';
import '../widgets/snakebar.dart';


class EditProduct extends StatefulWidget {
  final dynamic items;

  const EditProduct({Key? key, required this.items}) : super(key: key);

  @override
  State<EditProduct> createState() => _EditProductState();
}

final GlobalKey<ScaffoldMessengerState> _scaffoldKey =
    GlobalKey<ScaffoldMessengerState>();

class _EditProductState extends State<EditProduct> {

  late int number1;
  late int number2;
  late int number3;
  late int startwork;
  late int endwork;
  late int whats;
  late int delevery;
  late String proName;
  late String prodesc;
  late String address;
  late String facebook;
  late String instgram;
  late String youtube;
  late String proId;


  String mainCategValue = 'select category';
  String subCategValue = 'subcategory';

  List<String> subCategList = [];

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final ImagePicker _picker = ImagePicker();
  List<XFile>? imagesFlieList = [];
  List<dynamic> imagesUrlList = [];
  dynamic _pickedImageError;
  bool proeccing = false;


  void _pickProductImages() async {
    try {
      final pickeImage = await _picker.pickMultiImage(
          );
      setState(() {
        imagesFlieList = pickeImage!;
      });
    } catch (e) {
      setState(() {
        _pickedImageError = e;
      });
      print(_pickedImageError);
    }
  }

  Widget previewImages() {
    if (imagesFlieList!.isNotEmpty) {
      return InkWell(
        onLongPress: () {
          setState(() {
            imagesFlieList = [];
          });
        },
        child: ListView.builder(
            itemCount: imagesFlieList!.length,
            itemBuilder: (context, index) {
              return Image.file(File(imagesFlieList![index].path));
            }),
      );
    } else {
      return const Center(
        child: Text(
          'you have not \n \n picked image yet !',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 16),
        ),
      );
    }
  }

  Widget previewCurrentImages() {

    List<dynamic> itemImages = widget.items['proimage'];
    return ListView.builder(
        itemCount: itemImages.length,
        itemBuilder: (context, index) {
          return Image.network(itemImages[index].toString());
        });
  }


  void selectedMainCateg (String ? value){
    if (value == 'select category') {
      subCategList = [];
    } else if (value == 'shop') {
      subCategList = shop;
    }
    else if (value == 'shop2') {
      subCategList = shop2;
    }
    else if (value == 'furniture') {
      subCategList = furniture;
    }
    else if (value == 'finishingsupplies') {
      subCategList = finishingsupplies;
    }
    else if (value == 'clothesandshoes') {
      subCategList = clothesandshoes;
    }
    else if (value == 'service') {
      subCategList = service;
    }
    else if (value == 'medicalservices') {
      subCategList = medicalservices;
    }
    else if (value == 'car') {
      subCategList = car;
    }
    else if (value == 'education') {
      subCategList = education;
    }
    else if (value == 'carsservice') {
      subCategList = carsservice;
    }
    // else if (value == 'shopsrent') {
    //   subCategList = shopsrent;
    // }
    else if (value == 'freeprofessions') {
      subCategList = freeprofessions;
    }
    else if (value == 'doctor') {
      subCategList = doctor;
    }
    else if (value == 'primarystage') {
      subCategList = primarystage;
    }
    else if (value == 'middleschool') {
      subCategList = middleschool;
    }
    else if (value == 'highschool') {
      subCategList = highschool;
    }
    print(value);
    setState(() {
      mainCategValue = value!;
      subCategValue = 'subcategory';
    });
  }




  Future uploadImages()async{
    if (_formKey.currentState!.validate()) {
            _formKey.currentState!.save();
            if(imagesFlieList!.isNotEmpty){
              if (mainCategValue != 'select category' && subCategValue != 'subcategory') {
                try  {
                  for (var image in imagesFlieList!) {
                    firebase_storage.Reference ref = firebase_storage
                        .FirebaseStorage.instance
                        .ref('products/${path.basename(image.path)}');
                    await ref.putFile(File(image.path)).whenComplete(() async {
                      await ref.getDownloadURL().then((value) {
                        imagesUrlList.add(value);
                      });
                    });
                  }
                } catch (e) {
                  print(e);
                }
              }
              else{
                MyMassege.showSnakeBar(_scaffoldKey, 'select categories');
              }
            }
            else{
              imagesUrlList = widget.items['proimage'];
            }
    }
    else {
      MyMassege.showSnakeBar(_scaffoldKey, 'fill all fields');
    }

  }


  editProductData()async{
    await FirebaseFirestore.instance.runTransaction((transaction)async {
      DocumentReference documentReference = FirebaseFirestore.instance.collection('products')
          .doc(widget.items['proid']);
      transaction.update(documentReference, {
        'maincateg': mainCategValue,
        'subcateg': subCategValue,
        'number1': number1,
        'number2': number2,
        'number3': number3,
        'delevery': delevery,
        'startwork': startwork,
        'endwork': endwork,
        'whats': whats,
        'proname': proName,
        'prodec': prodesc,
        'address': address,
        'facebook': facebook,
        'instgram': instgram,
        'youtube': youtube,
        'proimage': imagesUrlList,
      });
    }).whenComplete(() => Navigator.pop(context));
  }

  saveChanges()async{
    await uploadImages().whenComplete(() => editProductData());
  }




  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return ScaffoldMessenger(
      key: _scaffoldKey,
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            reverse: true,
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    children: [
                      Row(children: [
                        Container(
                            color: Colors.blueGrey.shade100,
                            height: size.width * 0.5,
                            width: size.width * 0.5,
                            child: previewCurrentImages()),
                        SizedBox(
                          height: size.width * .5,
                          width: size.width * .5,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                children: [
                                  const Text(
                                    ' main category',
                                    style: TextStyle(color: Colors.red),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.all(6),
                                    margin: const EdgeInsets.all(6),
                                    constraints: BoxConstraints(
                                      minWidth: size.width * 0.3,
                                    ),
                                    decoration: BoxDecoration(
                                        color: Colors.yellow,
                                        borderRadius:
                                        BorderRadius.circular(10)),
                                    child: Center(
                                        child: Text(widget.items['maincateg'])),
                                  ),
                                ],
                              ),
                              Column(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    ' subcategory ',
                                    style: TextStyle(color: Colors.red),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.all(6),
                                    margin: const EdgeInsets.all(6),
                                    constraints: BoxConstraints(
                                      minWidth: size.width * 0.3,
                                    ),
                                    decoration: BoxDecoration(
                                        color: Colors.yellow,
                                        borderRadius:
                                        BorderRadius.circular(10)),
                                    child: Center(
                                        child: Text(widget.items['subcateg'])),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        )
                      ]),
                    ],
                  ),
                  ExpandablePanel(
                    theme: const ExpandableThemeData(
                      hasIcon: false ,
                    ),
                    header:  Padding(
                      padding:const EdgeInsets.all(10),
                      child: Container(
                        decoration: BoxDecoration(
                          color:Colors.yellow.withOpacity(0.5) ,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: const EdgeInsets.all(6),
                        child: const Center(
                          child:  Text(
                            'Change Images & Categories',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                    collapsed: const SizedBox(
                    ),
                    expanded: changeImages(size),
                  ),
                  const SizedBox(
                    height: 30,
                    child: Divider(
                      color: Colors.black,
                      thickness: 1.5,
                    ),
                  ),
                  // رقم التليفون الاول
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width * 0.35,
                          child: TextFormField(
                            initialValue:widget.items['number1'].toString(),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return ' ادخل رقم الهاتف';
                              }
                              return null;
                            },
                            onSaved: (value) {
                              number1 = int.parse(value!);
                            },
                            keyboardType: const TextInputType.numberWithOptions(
                                decimal: true),
                            decoration: textFormDecration.copyWith(
                              labelText: 'رقم النشاط',
                              hintText: '',
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 30,
                    child: Divider(
                      color: Colors.black,
                      thickness: 1.5,
                    ),
                  ),
                  // رقم التليفون التاني
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width * 0.35,
                          child: TextFormField(
                            initialValue:widget.items['number2'].toString(),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return ' ادخل رقم الهاتف';
                              }
                              return null;
                            },
                            onSaved: (value) {
                              number2 = int.parse(value!);
                            },
                            keyboardType: const TextInputType.numberWithOptions(
                                decimal: true),
                            decoration: textFormDecration.copyWith(
                              labelText: 'رقم النشاط الثاني',
                              hintText: '',
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 30,
                    child: Divider(
                      color: Colors.black,
                      thickness: 1.5,
                    ),
                  ),
                  // رقم التليفون الثالث
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width * 0.35,
                          child: TextFormField(
                            initialValue:widget.items['number3'].toString(),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return ' ادخل رقم الهاتف الثالث';
                              }
                              return null;
                            },
                            onSaved: (value) {
                              number3 = int.parse(value!);
                            },
                            keyboardType: const TextInputType.numberWithOptions(
                                decimal: true),
                            decoration: textFormDecration.copyWith(
                              labelText: 'رقم النشاط الثالث',
                              hintText: '',
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 30,
                    child: Divider(
                      color: Colors.black,
                      thickness: 1.5,
                    ),
                  ),
                  // رقم التليفون الواتس
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width * 0.35,
                          child: TextFormField(
                            initialValue:widget.items['whats'].toString(),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return ' ادخل رقم الواتس اب';
                              }
                              return null;
                            },
                            onSaved: (value) {
                              whats = int.parse(value!);
                            },
                            keyboardType: const TextInputType.numberWithOptions(
                                decimal: true),
                            decoration: textFormDecration.copyWith(
                              labelText: 'رقم الواتس',
                              hintText: '',
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 30,
                    child: Divider(
                      color: Colors.black,
                      thickness: 1.5,
                    ),
                  ),
                  // رقم التليفون الدليفري
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width * 0.35,
                          child: TextFormField(
                            initialValue:widget.items['delevery'].toString(),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return ' ادخل رقم الدليفري';
                              }
                              return null;
                            },
                            onSaved: (value) {
                              delevery = int.parse(value!);
                            },
                            keyboardType: const TextInputType.numberWithOptions(
                                decimal: true),
                            decoration: textFormDecration.copyWith(
                              labelText: 'رقم الدليفري',
                              hintText: '',
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 30,
                    child: Divider(
                      color: Colors.black,
                      thickness: 1.5,
                    ),
                  ),
                  // بداية العمل
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width * 0.35,
                          child: TextFormField(
                            initialValue:widget.items['startwork'].toString(),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return ' ادخل وقت بداية العمل ';
                              }
                              return null;
                            },
                            onSaved: (value) {
                               startwork= int.parse(value!);
                            },
                            keyboardType: const TextInputType.numberWithOptions(
                                decimal: true),
                            decoration: textFormDecration.copyWith(
                              labelText: 'بداية العمل ',
                              hintText: '',
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 30,
                    child: Divider(
                      color: Colors.black,
                      thickness: 1.5,
                    ),
                  ),
                  // نهاية العمل
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width * 0.35,
                          child: TextFormField(
                            initialValue:widget.items['endwork'].toString(),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return ' ادخل وقت نهاية العمل ';
                              }
                              return null;
                            },
                            onSaved: (value) {
                              endwork = int.parse(value!);
                            },
                            keyboardType: const TextInputType.numberWithOptions(
                                decimal: true),
                            decoration: textFormDecration.copyWith(

                              labelText: 'رقم نهاية العمل',
                              hintText: '',
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 30,
                    child: Divider(
                      color: Colors.black,
                      thickness: 1.5,
                    ),
                  ),
                  // اسم النشاط
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.4,
                      child: TextFormField(
                        initialValue:widget.items['proname'],
                        validator: (value) {

                          if (value!.isEmpty) {
                            return 'الرجاء ادخل اسم النشاط';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          proName = (value!);
                        },
                        maxLength: 100,
                        maxLines: 3,
                        decoration: textFormDecration.copyWith(
                          labelText: 'اسم النشاط',
                          hintText: '',
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                    child: Divider(
                      color: Colors.black,
                      thickness: 1.5,
                    ),
                  ),
                  //تفاصيل النشاط
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.9,
                      child: TextFormField(
                        initialValue:widget.items['prodec'],
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'ادخل تفاصيل النشاط';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          prodesc = (value!);
                        },
                        maxLength: 800,
                        maxLines: 5,
                        decoration: textFormDecration.copyWith(
                          labelText: 'تفاصيل النشاط',
                          hintText: '',
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                    child: Divider(
                      color: Colors.black,
                      thickness: 1.5,
                    ),
                  ),
                  // عنوان النشاط
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.4,
                      child: TextFormField(
                        initialValue:widget.items['address'],
                        validator: (value) {

                          if (value!.isEmpty) {
                            return 'الرجاء عنوان النشاط';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          address = (value!);
                        },
                        maxLength: 100,
                        maxLines: 3,
                        decoration: textFormDecration.copyWith(
                          labelText: 'عنوان النشاط',
                          hintText: '',
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                    child: Divider(
                      color: Colors.black,
                      thickness: 1.5,
                    ),
                  ),
                  // الفيس بوك
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.4,
                      child: TextFormField(
                        initialValue:widget.items['facebook'],
                        validator: (value) {

                          if (value!.isEmpty) {
                            return 'الرجاء الفيس بوك ';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          facebook = (value!);
                        },
                        maxLength: 100,
                        maxLines: 2,
                        decoration: textFormDecration.copyWith(
                          labelText: 'الفيس بوك ',
                          hintText: '',
                        ),
                      ),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.4,
                      child: TextFormField(
                        initialValue:widget.items['instgram'],
                        validator: (value) {

                          if (value!.isEmpty) {
                            return 'انستجرام';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          instgram = (value!);
                        },
                        maxLength: 100,
                        maxLines: 2,
                        decoration: textFormDecration.copyWith(
                          labelText: ' انستجرام ',
                          hintText: '',
                        ),
                      ),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.4,
                      child: TextFormField(
                        initialValue:widget.items['youtube'],
                        validator: (value) {

                          if (value!.isEmpty) {
                            return 'يوتيوب ';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          youtube = (value!);
                        },
                        maxLength: 100,
                        maxLines: 2,
                        decoration: textFormDecration.copyWith(
                          labelText: ' يوتيوب ',
                          hintText: '',
                        ),
                      ),
                    ),
                  ),

                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          YellowButton(
                            lable: 'Cancel',
                            onPress: () {
                              Navigator.pop(context);
                            },
                            width: 0.25,
                          ),
                          YellowButton(
                            lable: 'Saved Changes',
                            onPress: ()  {
                              saveChanges();
                            },
                            width: 0.5,
                          ),

                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: PinkButton(
                          lable: 'Delete item', width: 0.7,
                          onPress: ()async {
                            await FirebaseFirestore.instance.runTransaction((
                                transaction) async {
                              DocumentReference documentRefranecr = FirebaseFirestore
                                  .instance.collection('products')
                                  .doc(widget.items['proid']);
                              transaction.delete(documentRefranecr);
                            },
                            ).whenComplete(() => Navigator.pop(context));
                          }
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget changeImages(Size size) {
    return Column(
      children: [
        Row(children: [
          Container(
            color: Colors.blueGrey.shade100,
            height: size.width * 0.5,
            width: size.width * 0.5,
            child: imagesFlieList != null
                ? previewImages()
                : const Center(
                    child: Text(
                      'you have not \n \n picked image yet !',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
          ),
          SizedBox(
            height: size.width * .5,
            width: size.width * .5,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  children: [
                    const Text(
                      '* select main category',
                      style: TextStyle(color: Colors.red),
                    ),
                    DropdownButton(
                      iconSize: 40,
                      iconEnabledColor: Colors.red,
                      dropdownColor: Colors.yellow.shade400,
                      value: mainCategValue,
                      items: maincateg.map<DropdownMenuItem<String>>((value) {
                        return DropdownMenuItem(
                          child: Text(value),
                          value: value,
                        );
                      }).toList(),
                      onChanged: (String? value) {
                        selectedMainCateg(value);
                      },
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      '* select subcategory ',
                      style: TextStyle(color: Colors.red),
                    ),
                    DropdownButton(
                      iconSize: 40,
                      iconDisabledColor: Colors.black,
                      iconEnabledColor: Colors.red,
                      dropdownColor: Colors.yellow.shade400,
                      disabledHint: const Text('select category'),
                      value: subCategValue,
                      items: subCategList.map<DropdownMenuItem<String>>((value) {
                        return DropdownMenuItem(
                          child: Text(value),
                          value: value,
                        );
                      }).toList(),
                      onChanged: (String? value) {
                        print(value);
                        setState(() {
                          subCategValue = value!;
                        });
                      },
                    ),
                  ],
                ),
              ],
            ),
          )
        ]),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: imagesFlieList!.isNotEmpty? YellowButton(lable: 'Reset  Images', onPress: (){
            setState(() {
              imagesFlieList = [];
            });
          }, width: 0.6):
          YellowButton(lable: ' Change Images', onPress: (){
            _pickProductImages();
          }, width: 0.6),
        )
      ],
    );
  }
}

var textFormDecration = InputDecoration(
  labelText: '',
  hintText: '',
  labelStyle: const TextStyle(color: Colors.purple),
  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
  enabledBorder: OutlineInputBorder(
    borderSide: const BorderSide(color: Colors.black54, width: 1),
    borderRadius: BorderRadius.circular(10),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: const BorderSide(color: Colors.black54, width: 1),
    borderRadius: BorderRadius.circular(10),
  ),
);

