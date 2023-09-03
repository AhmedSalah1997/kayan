// ignore_for_file: avoid_print

import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:path/path.dart' as path;
import 'package:uuid/uuid.dart';

import '../widgets/snakebar.dart';



class UploadSliderScreen extends StatefulWidget {
  const UploadSliderScreen({Key? key}) : super(key: key);

  @override
  State<UploadSliderScreen> createState() => _UploadSliderScreenState();
}

final GlobalKey<ScaffoldMessengerState> _scaffoldKey =
GlobalKey<ScaffoldMessengerState>();

class _UploadSliderScreenState extends State<UploadSliderScreen> {
  late int number;
  late int salary;
  late int whats;
  late String text;
  late String prodesc;
  late String youtube;
  late String facebook;
  late String address;
  late String timework;
  late String proId;
  List<String> subCategList = [];

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final ImagePicker _picker = ImagePicker();
  List<XFile>? imagesFlieList = [];
  List<String> imagesUrlList = [];
  dynamic _pickedImageError;
  bool proeccing = false;
// حجم الصورة


  void _pickProductImages() async {
    try {
      final pickeImage = await _picker.pickMultiImage(
          maxHeight: 300, maxWidth: 300, imageQuality: 95);
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

// رفع صورة
  Future<void> uploadImage() async {
      if (_formKey.currentState!.validate()) {
        _formKey.currentState!.save();
        if (imagesFlieList!.isNotEmpty) {
          setState(() {
            proeccing = true;
          });
          try{
            for(var image in imagesFlieList!){
              firebase_storage.Reference ref = firebase_storage.FirebaseStorage.instance.ref(
                  'slider/${path.basename(image.path)}'
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
  }

// رفع البيانات على الفاير بيز
  void uploadData()async{
    if(imagesUrlList.isNotEmpty){
      CollectionReference productRef = FirebaseFirestore.instance.collection('slider');
      proId = const Uuid().v4();
      await productRef.doc(proId).set({
        'proid': proId,
        'number':number,
        'salary':salary,
        'whats':whats,
        'text':text,
        'prodec': prodesc,
        'youtube': youtube,
        'facebook': facebook,
        'address': address,
        'timework': '',
        'sid':FirebaseAuth.instance.currentUser!.uid,
        'proimage': imagesUrlList,

      }).whenComplete(() {
        setState(() {
          proeccing = false;
          imagesFlieList = [];
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
    await uploadImage().whenComplete(() =>uploadData());
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
                  // اختيار صورة
                  Row(
                      children: [
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
                       ]
                  ),
                  const SizedBox(
                    height:15,
                    child: Divider(
                      color: Colors.black,
                      thickness: .5,
                    ),
                  ),
                  // رقم تواصل 1
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.45,
                        child: TextFormField(
                          onSaved: (value) {
                            number = int.parse(value!);
                          },
                          keyboardType: const TextInputType.numberWithOptions(
                              decimal: true),
                          decoration: textFormDecration.copyWith(
                            labelText: 'رقم تواصل',
                            hintText: '',
                          ),
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.45,
                        child: TextFormField(
                          onSaved: (value) {
                            whats = int.parse(value!);
                          },
                          keyboardType: const TextInputType.numberWithOptions(
                              decimal: true),
                          decoration: textFormDecration.copyWith(
                            labelText: 'رقم واتس',
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
                  // اسم الاعلان
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.45,
                        child: TextFormField(
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'ادخل نص توضيحي';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            text = (value!);
                          },
                          decoration: textFormDecration.copyWith(
                            labelText: 'نص توضيحي',
                            hintText: '',
                          ),
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.45,
                        child: TextFormField(
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'ادخل الراتب';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            salary = int.parse(value!);
                          },
                          maxLines: 1,
                          decoration: textFormDecration.copyWith(
                            labelText: 'الراتب ',
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
                  // وصف الاعلان
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.99,
                    child: TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'وصف الاعلان';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        prodesc = (value!);
                      },
                      maxLines: 2,
                      decoration: textFormDecration.copyWith(
                        labelText: 'وصف الاعلان ',
                        hintText: '',
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
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.99,
                    child: TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'عنوان';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        address = (value!);
                      },
                      maxLines: 1,
                      decoration: textFormDecration.copyWith(
                        labelText: 'عنوان الاعلان ',
                        hintText: '',
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
                  // يوتيوب
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.99,
                    child: TextFormField(
                      onSaved: (value) {
                        youtube = (value!);
                      },
                      maxLength: 800,
                      maxLines: 2,
                      decoration: textFormDecration.copyWith(
                        labelText: 'صفحه يوتيوب ان وجد',
                        hintText: '',
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                    child: Divider(
                      color: Colors.black,
                      thickness:.5,
                    ),
                  ),
                  // صفحه الفيس
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.99,
                    child: TextFormField(
                      onSaved: (value) {
                        facebook = (value!);
                      },
                      maxLines: 2,
                      decoration: textFormDecration.copyWith(
                        labelText: 'فيس بوك ان وجد',
                        hintText: '',
                      ),
                    ),
                  ),
                  const SizedBox(
                    height:77,
                  ),
                ],
              ),
            ),
          ),
        ),
        floatingActionButton: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(width: 10,),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: FloatingActionButton(
                onPressed: proeccing == true
                    ? null
                    :() {
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
                _pickProductImages();
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
