// ignore_for_file: library_private_types_in_public_api

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';



class News extends StatefulWidget {
  const News({Key? key}) : super(key: key);

  @override
  _NewsState createState() => _NewsState();
}

class _NewsState extends State<News> {



  late final Stream<QuerySnapshot> _prodcutsStream2 =
  FirebaseFirestore.instance.collection('news').snapshots();



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: StreamBuilder<QuerySnapshot>(
          stream: _prodcutsStream2,
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return const Text('Something is wrong');
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(
                  color: Colors.purple,
                ),
              );
            }
            if (snapshot.data!.docs.isEmpty) {
              return const Center(
                child: Text(
                  '',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 26,
                      color: Colors.blueGrey,
                      fontFamily: 'Acme',
                      letterSpacing: 1.5),
                ),
              );
            }
            return Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
              ),
              height: MediaQuery.of(context).size.height*0.15,
              width: double.infinity,
              child: CarouselSlider.builder(
                // clipBehavior : Clip.none,
                  autoSliderDelay: const Duration(seconds: 4),
                  enableAutoSlider: true,
                  unlimitedMode: true,
                  slideBuilder: (index) {
                    return Container(
                        alignment: Alignment.center,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(25),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text(snapshot.data!.docs[index]['label'],style: TextStyle(color: Colors.indigo),),
                            ],
                          ),
                        ));
                  },
                  slideTransform: CubeTransform(
                    rotationAngle: 0,
                  ),
                  itemCount: snapshot.data!.docs.length),
            );
          }),
    );
  }
}
