// ignore_for_file: avoid_print

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:path/path.dart' as path;
import 'package:uuid/uuid.dart';

import '../ulited/categ_list.dart';
import '../widgets/snakebar.dart';



class UploadProdouctScreen extends StatefulWidget {
  const UploadProdouctScreen({Key? key}) : super(key: key);

  @override
  State<UploadProdouctScreen> createState() => _UploadProdouctScreenState();
}

final GlobalKey<ScaffoldMessengerState> _scaffoldKey =
    GlobalKey<ScaffoldMessengerState>();

class _UploadProdouctScreenState extends State<UploadProdouctScreen> {
  late int number2;
  late int number1;
  late int number3;
  late int delevery;
  late String isdelvery;
  late int whats;
  late String proName;
  late String prodesc;
  late String address;
  late String facebook;
  late String instgram;
  late String youtube;
  late String proId;
  late String startwork ;
  late String endwork ;

  String mainCategValue = 'select category';
  String subCategValue = 'subcategory';

  List<String> subCategList = [];

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final ImagePicker _picker = ImagePicker();
  List<XFile>? imagesFlieList = [];
  List<String> imagesUrlList = [];
  dynamic _pickedImageError;
  bool proeccing = false;

// حجم الصورة
  void _pickProductImages1() async {
    try {
      final pickeImage = await _picker.pickMultiImage(
          // maxHeight: 300, maxWidth: 300, imageQuality: 100
      );
      setState(() {
        imagesFlieList = pickeImage;
      });
    } catch (e) {
      setState(() {
        _pickedImageError = e;
      });
      print(_pickedImageError);
    }
  }


// عرض الصورة معاينة
  Widget previewImages1() {
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


// رفع كاتوجري


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
// رفع صورة
  Future<void> uploadImage1() async {
    if (mainCategValue != 'select category' && subCategValue !='subcategory' ) {
      if (_formKey.currentState!.validate()) {
        _formKey.currentState!.save();
        if (imagesFlieList!.isNotEmpty) {
          setState(() {
            proeccing = true;
          });
          try{
            for(var image in imagesFlieList!){
              firebase_storage.Reference ref = firebase_storage.FirebaseStorage.instance.ref(
                  'products/${path.basename(image.path)}'
              );
              await ref.putFile(File(image.path)).whenComplete(() async{
                await ref.getDownloadURL().then((value) {
                  imagesUrlList.add(value);
                });
              })  ;
            }
          }catch(e)

          {print(e);}


        } else {
          MyMassege.showSnakeBar(_scaffoldKey, 'please pick images first');
        }
      } else {
        MyMassege.showSnakeBar(_scaffoldKey, 'please fill all field');
      }
    } else {
      MyMassege.showSnakeBar(_scaffoldKey, 'select categories');
    }
  }

// رفع البيانات على الفاير بيز
  void uploadData()async{
    if(imagesUrlList.isNotEmpty){
      CollectionReference productRef = FirebaseFirestore.instance.collection('products');
      proId = const Uuid().v4();
      await productRef.doc(proId).set({
        'proid': proId,
        'maincateg': mainCategValue,
        'subcateg': subCategValue,
        'number1':number1,
        'number2':number2,
        'number3':number3,
        'delevery':delevery,
        'isdelvery':isdelvery,
        'startwork':startwork,
        'endwork':endwork,
        'whats':whats,
        'proname':proName,
        'prodec': prodesc,
        'address': address,
        'facebook': facebook,
        'instgram': instgram,
        'youtube': youtube,
        'sid':FirebaseAuth.instance.currentUser!.uid,
        'proimage': imagesUrlList,


      }).whenComplete(() {
        setState(() {
          proeccing = false;
          imagesFlieList = [];

          mainCategValue = 'select category';
          subCategList = [];
          imagesUrlList = [];

        });
        _formKey.currentState!.reset();
      });
    }else{
        print('no images');
    }
  }

 void uploadProduct()async{
    await uploadImage1().whenComplete(() =>uploadData());

 }


  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size ;
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
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  // اختيار النشاط
                  Row(
                    children: [
                      Container(
                        color: Colors.blueGrey.shade100,
                        height: size.width * 0.5,
                        width: size.width * 0.5,
                        child: imagesFlieList != null
                            ? previewImages1()
                            : const Center(
                                child: Text(
                                  'you have not \n \n picked image yet !',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(fontSize: 16),
                                ),
                              ),
                      ),
                      SizedBox(
                        height: size.width*.5,
                        width: size.width*.5,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              children: [
                                const Text('* select main category' ,
                                style: TextStyle(color: Colors.red),),
                                DropdownButton(
                                  iconSize: 40,
                                  iconEnabledColor: Colors.red,
                                  dropdownColor: Colors.yellow.shade400,
                                  value: mainCategValue,
                                  items:maincateg
                                      .map<DropdownMenuItem<String>>((value) {
                                    return DropdownMenuItem(
                                      value: value,
                                      child: Text(value),
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
                                    '* select subcategory ' , style: TextStyle(color: Colors.red),
                                  ),
                                  DropdownButton(
                                    iconSize: 40,
                                    iconDisabledColor: Colors.black,
                                    iconEnabledColor: Colors.red,
                                    dropdownColor: Colors.yellow.shade400,
                                    disabledHint: const Text('select category'),
                                    value: subCategValue,
                                    items:subCategList
                                        .map<DropdownMenuItem<String>>((value) {
                                      return DropdownMenuItem(
                                        value: value,
                                        child: Text(value),
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
                      )]
                  ),
                  const SizedBox(
                    height: 5,
                    child: Divider(
                      color: Colors.black,
                      thickness: .5,
                    ),
                  ),

                  // رقم تواصل 1 , 2
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.45,
                        child: TextFormField(
                          validator: (value) {
                            if (value!.isEmpty) {
                              return ' رجاء ادخل رقم النشاط';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            number1 = int.parse(value!);
                          },
                          keyboardType: const TextInputType.numberWithOptions(
                              decimal: true),
                          decoration: textFormDecration.copyWith(
                            labelText:'رقم نشاط1',
                            hintText: '',
                          ),
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.45,
                        child: TextFormField(
                          validator: (value) {
                            if (value!.isEmpty) {
                              return ' رجاء ادخل رقم النشاط';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            number2 = int.parse(value!);
                          },
                          keyboardType: const TextInputType.numberWithOptions(
                              decimal: true),
                          decoration: textFormDecration.copyWith(
                            labelText: 'رقم نشاط 2',
                            hintText: '',
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                    child: Divider(
                      color: Colors.black,
                      thickness: .5,
                    ),
                  ),

                  // رقم تواصل3 وواتس
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.45,
                        child: TextFormField(
                          validator: (value) {
                            if (value!.isEmpty) {
                              return ' رجاء ادخل رقم النشاط';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            number3 = int.parse(value!);
                          },
                          keyboardType: const TextInputType.numberWithOptions(
                              decimal: true),
                          decoration: textFormDecration.copyWith(
                            labelText:'رقم نشاط3',
                            hintText: '',
                          ),
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.45,
                        child: TextFormField(
                          validator: (value) {
                            if (value!.isEmpty) {
                              return ' رجاء ادخل رقم النشاط';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            whats = int.parse(value!);
                          },
                          keyboardType: const TextInputType.numberWithOptions(
                              decimal: true),
                          decoration: textFormDecration.copyWith(
                            labelText: 'رقم واتس ',
                            hintText: '',
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                    child: Divider(
                      color: Colors.black,
                      thickness: .5,
                    ),
                  ),
                  // دليفري ولا لا
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.45,
                        child: TextFormField(
                          validator: (value) {
                            if (value!.isEmpty) {
                              return ' رجاء ادخل رقم الدليفري الخاص';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            delevery = int.parse(value!);
                          },
                          keyboardType: const TextInputType.numberWithOptions(
                              decimal: true),
                          decoration: textFormDecration.copyWith(
                            labelText:'رقم دليفري خاص ',
                            hintText: '',
                          ),
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.45,
                        child: TextFormField(
                          validator: (value) {
                            if (value!.isEmpty) {
                              return ' رجاء نوع الدليفري   ';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            isdelvery = (value!);
                          },
                          decoration: textFormDecration.copyWith(
                            labelText: '( noغير مشترك)(yes له)',
                            hintText: '',
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                    child: Divider(
                      color: Colors.black,
                      thickness: .5,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.45,
                        child: TextFormField(
                          validator: (value) {
                            if (value!.isEmpty) {
                              return ' بداية العمل';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            startwork = (value!);
                          },
                          decoration: textFormDecration.copyWith(
                            labelText:'بداية العمل',
                            hintText: '',
                          ),
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.45,
                        child: TextFormField(
                          validator: (value) {
                            if (value!.isEmpty) {
                              return ' نهاية العمل ';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            endwork = (value!);
                          },
                          decoration: textFormDecration.copyWith(
                            labelText: 'نهاية العمل',
                            hintText: '',
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                    child: Divider(
                      color: Colors.black,
                      thickness: .5,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.99,
                      child: TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'رجاء وصف النشاط';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          prodesc = (value!);
                        },
                        maxLength: 800,
                        maxLines: 2,
                        decoration: textFormDecration.copyWith(
                          labelText: 'وصف النشاط ',
                          hintText: '',
                        ),
                      ),
                    ),
                  ),
                  // وصف النشاط
                  const SizedBox(
                    height: 5,
                    child: Divider(
                      color: Colors.black,
                      thickness: .5,
                    ),
                  ),
                  // اسم النشاط
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.99,
                      child: TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'رجاء اكتب اسم النشاط';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          proName = (value!);
                        },
                        maxLines: 1,
                        decoration: textFormDecration.copyWith(
                          labelText: 'اسم النشاط ',
                          hintText: '',
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                    child: Divider(
                      color: Colors.black,
                      thickness: .5,
                    ),
                  ),
                  // العنوان
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.99,
                      child: TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'رجاء ادخل العنوان';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          address = (value!);
                        },
                        maxLines: 1,
                        decoration: textFormDecration.copyWith(
                          labelText: 'عنوان النشاط',
                          hintText: '',
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                    child: Divider(
                      color: Colors.black,
                      thickness: .5,
                    ),
                  ),
                  // صفحه الفيس
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.99,
                      child: TextFormField(
                        onSaved: (value) {
                          facebook = (value!);
                        },
                        maxLines: 2,
                        decoration: textFormDecration.copyWith(
                          labelText: 'صفحه فيس بوك',
                          hintText: '',
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.99,
                      child: TextFormField(
                        onSaved: (value) {
                          instgram = (value!);
                        },
                        maxLines: 2,
                        decoration: textFormDecration.copyWith(
                          labelText: 'صفحه انتسجرام',
                          hintText: '',
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.99,
                      child: TextFormField(
                        onSaved: (value) {
                          youtube = (value!);
                        },
                        maxLines: 2,
                        decoration: textFormDecration.copyWith(
                          labelText: 'صفحه يوتيوب',
                          hintText: '',
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 80,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const SizedBox(width: 10,),
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: FloatingActionButton(
                          onPressed: proeccing == true
                              ? null
                              :()  {
                            uploadProduct();

                          },
                          backgroundColor: Colors.blueAccent,
                          child:proeccing== true ?
                          const CircularProgressIndicator(color: Colors.purple,):
                          const Icon(
                            Icons.upload,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      const SizedBox(width: 10,),
                      FloatingActionButton(
                        onPressed: imagesFlieList!.isEmpty
                            ? () {
                          _pickProductImages1();

                        }
                            : () {
                          setState(() {
                            imagesFlieList = [];
                          });
                        },
                        backgroundColor: Colors.blueAccent,
                        child: imagesFlieList!.isEmpty
                            ? const Icon(
                          Icons.photo_library,
                          color: Colors.black,
                        )
                            : const Icon(
                          Icons.delete_forever,
                          color: Colors.redAccent,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

var textFormDecration = InputDecoration(
  labelText: 'price',
  hintText: 'price..\$',
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

