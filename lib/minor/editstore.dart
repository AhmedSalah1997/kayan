import 'dart:io';


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

import '../widgets/button.dart';
import '../widgets/snakebar.dart';
import 'appbarwidget.dart';

class EditStore extends StatefulWidget {
  final dynamic data ;
  const EditStore({Key? key, required this.data}) : super(key: key);

  @override
  State<EditStore> createState() => _EditStoreState();
}

class _EditStoreState extends State<EditStore> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldMessengerState> _scaffoldKey = GlobalKey<ScaffoldMessengerState>();
  XFile? imageFileLogo;
  XFile? imageFileCover;
  final ImagePicker _imagePicker = ImagePicker();
  dynamic _pickedImageError ;
  late String storeName;
  late String phone;
  late String storeLogo;
  late String coverImage;
  bool processing = false ;


     pickStoreLogoImage() async {
      try {
        final pickeStoreLogo = await _imagePicker.pickImage(
            source: ImageSource.gallery,
            maxHeight: 300,
            maxWidth: 300,
            imageQuality: 95);
        setState(() {
          imageFileLogo = pickeStoreLogo;
        });
      } catch (e) {
        setState(() {
          _pickedImageError = e;
        });
        print(_pickedImageError);
      }
    }
      pickCoverImage() async {
      try {
        final pickeCoverImage = await _imagePicker.pickImage(
            source: ImageSource.gallery,
            maxHeight: 300,
            maxWidth: 300,
            imageQuality: 95);
        setState(() {
          imageFileCover = pickeCoverImage;
        });
      } catch (e) {
        setState(() {
          _pickedImageError = e;
        });
        print(_pickedImageError);
      }
    }

    Future uploadStoreLogo()async {
       if(imageFileLogo != null){
         try{
           firebase_storage.Reference ref = firebase_storage
               .FirebaseStorage.instance
               .ref('supp-images/${widget.data['email']}.jpg');

           await ref.putFile(File(imageFileLogo!.path));

           storeLogo = await ref.getDownloadURL();

         }catch(e){}
       }else{
         storeLogo = widget.data['storelogo'];
       }
       }

  Future uploadCoverImage()async {
       if(imageFileLogo != null){
         try{
           firebase_storage.Reference ref2 = firebase_storage
               .FirebaseStorage.instance
               .ref('supp-images/${widget.data['email']}.jpg-cover');

           await ref2.putFile(File(imageFileCover!.path));

           coverImage = await ref2.getDownloadURL();

         }catch(e){}
       }else{
         coverImage = widget.data['coverimage'];
       }
       }

  editStorData()async{
    await FirebaseFirestore.instance.runTransaction((transaction)async{
      DocumentReference documentReference = FirebaseFirestore.instance.
      collection('suppliers').doc(FirebaseAuth.instance.currentUser!.uid);
      transaction.update(documentReference, {
        'storename':storeName,
        'phone':phone,
        'storlogo':storeLogo,
        'coverimage':coverImage,

      });
    }).whenComplete(() => Navigator.pop(context));
  }


  saveChanges()async{
       if(formKey.currentState!.validate()){
       formKey.currentState!.save();
       setState(() {
         processing = true;
       });
       await uploadStoreLogo().whenComplete(() async{
         return await uploadCoverImage().whenComplete(() {
           return editStorData();
         });
       });
       }else {
         MyMassege.showSnakeBar(_scaffoldKey,
         'please fill all fields'
         );
       }
  }



  @override
  Widget build(BuildContext context) {
    return ScaffoldMessenger(
      key:_scaffoldKey ,
        child: Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: const AppBarBackButton(),
        title:const AppBarTitle(
          title: 'edit store',
        ),
      ),
      body: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              children: [
                Column(
                  children: [
                    const Text('Store Logo', style: TextStyle(
                        fontSize: 24 , color: Colors.blueGrey, fontWeight: FontWeight.w600
                    ),),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        CircleAvatar(
                          radius: 60,
                          backgroundImage: NetworkImage(widget.data['storlogo']),
                        ),
                        Column(
                          children: [
                            YellowButton(
                              width:.25 ,
                              onPress:(){
                                pickStoreLogoImage();
                              } ,
                              lable: 'Change',
                            ),
                            const SizedBox(height: 10,),
                            imageFileLogo== null? const SizedBox():  YellowButton(
                              width:.25 ,
                              onPress:(){
                                setState(() {
                                  imageFileLogo = null;
                                });
                              } ,
                              lable: 'Reset',
                            ),
                          ],
                        ),
                        imageFileLogo == null ? const SizedBox():   CircleAvatar(
                          radius: 60,
                          backgroundImage: FileImage(File(imageFileLogo!.path)),
                        ),
                      ],
                    ),
                    const Padding(padding: EdgeInsets.all(16),child: Divider(
                      color: Colors.black,
                      thickness: 1.5,
                    ),)
                  ],

                ),
                Column(
                  children: [
                    const Text('Cover Image', style: TextStyle(
                        fontSize: 24 , color: Colors.blueGrey, fontWeight: FontWeight.w600
                    ),),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        CircleAvatar(
                          radius: 60,
                          backgroundImage: NetworkImage(widget.data['coverimage']),
                        ),
                        Column(
                          children: [
                            YellowButton(
                              width:.25 ,
                              onPress:(){
                                pickCoverImage();
                              } ,
                              lable: 'Change',
                            ),
                            const SizedBox(height: 10,),
                            imageFileCover== null? const SizedBox():  YellowButton(
                              width:.25 ,
                              onPress:(){
                                setState(() {
                                  imageFileCover = null;
                                });
                              } ,
                              lable: 'Reset',
                            ),
                          ],
                        ),
                        imageFileCover == null ? const SizedBox():   CircleAvatar(
                          radius: 60,
                          backgroundImage: FileImage(File(imageFileCover!.path)),
                        ),
                      ],
                    ),
                    const Padding(padding: EdgeInsets.all(16),child: Divider(
                      color: Colors.black,
                      thickness: 1.5,
                    ),)
                  ],

                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    validator: (value){
                      if(value!.isEmpty){
                        return 'please Enter Store name';
                      }return null ;
                    },
                    onSaved: (value){
                      storeName = value!;
                    },
                    initialValue: widget.data['storename'],
                    decoration: textFormDecration.copyWith(
                        labelText: 'store name',
                        hintText: 'Enter Store name'
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    validator: (value){
                      if(value!.isEmpty){
                        return 'please Enter number Phone';
                      }return null ;
                    },
                    onSaved: (value){
                      phone = value!;
                    },
                    initialValue: widget.data['phone'],
                    decoration: textFormDecration.copyWith(
                        labelText: ' phone',
                        hintText: 'Enter Phone'
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 40),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      YellowButton(lable: 'Cancel', onPress: (){
                        Navigator.pop(context);
                      }, width: 0.25),
                   processing== true
                       ?  YellowButton(lable: 'please wait', onPress: (){
                     null;

                   }, width: 0.3)
                       :  YellowButton(lable: 'Save Changs', onPress: (){
                     saveChanges();

                   }, width: 0.3),


                    ],
                  ),
                )
              ],
            ),
          )
      ),
    )
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
