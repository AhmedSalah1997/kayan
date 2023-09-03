import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_carousel_slider/carousel_slider.dart';

import '../causel.dart';

class Sliderr extends StatefulWidget {
  const Sliderr({Key? key}) : super(key: key);

  @override
  State<Sliderr> createState() => _SliderrState();
}

class _SliderrState extends State<Sliderr> {

  late final Stream<QuerySnapshot> _prodcutsStream = FirebaseFirestore.instance
      .collection('slider')
      .snapshots();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: _prodcutsStream,
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
                'this category \n\n has no item yet ',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 26,
                    color: Colors.blueGrey,
                    fontFamily: 'Acme',
                    letterSpacing: 1.5),
              ),
            );
          }
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  // slider
                  Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      height: MediaQuery
                          .of(context)
                          .size
                          .height * 0.30,
                      width: double.infinity,
                      child: InkWell(
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                                return Casuler();
                              }));
                        },
                        child: CarouselSlider.builder(
                          // clipBehavior : Clip.none,
                            autoSliderDelay: const Duration(seconds: 5),
                            enableAutoSlider: true,
                            unlimitedMode: true,
                            slideBuilder: (index) {
                              DocumentSnapshot sliderimage =
                              snapshot.data!.docs[index];
                              return Container(
                                  alignment: Alignment.center,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(15),
                                    child: Image.network(
                                      sliderimage['proimage'][index],
                                      height: double.infinity,
                                      width: double.infinity,
                                      fit: BoxFit.cover,
                                    ),
                                  ));
                            },
                            slideTransform: CubeTransform(
                              rotationAngle: 0,
                            ),
                            slideIndicator: CircularSlideIndicator(
                              currentIndicatorColor: Colors.indigo,
                              padding: EdgeInsets.only(bottom: 5),
                            ),
                            itemCount: snapshot.data!.docs.length),
                      )),
                ],
              ),
            ),
          );
        });
  }}
