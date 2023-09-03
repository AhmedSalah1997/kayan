// ignore_for_file: avoid_print, unrelated_type_equality_checks

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provides/id_provider.dart';
import 'data/data.dart';

class OnBoarding extends StatefulWidget {
  const OnBoarding({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _OnBoardingState createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  // final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  Timer? countDownTimer;
  int scounds = 5;
  List<SliderModel> mySLides = <SliderModel>[];
  int slideIndex = 0;
  late PageController controller;


  @override
  void initState() {
    context.read<IdProvider>().getDocId();
    // startTimer();
    mySLides = getSlides();
    controller = PageController();
    super.initState();
  }
  Widget _buildPageIndicator(bool isCurrentPage) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 2.0),
      height: isCurrentPage ? 10.0 : 6.0,
      width: isCurrentPage ? 10.0 : 6.0,
      decoration: BoxDecoration(
        color: isCurrentPage ? const Color(0xFFBB0F4B) : Colors.grey[300],
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SizedBox(
        height: MediaQuery.of(context).size.height - 100,
        child: PageView(
          controller: controller,
          onPageChanged: (index) {
            setState(() {
              slideIndex = index;
            });
          },
          children: <Widget>[
            SlideTile(
              imagePath: mySLides[0].getImageAssetPath(),
              title: mySLides[0].getTitle(),
              subtitle: mySLides[0].getSubTitle(),
              // desc: mySLides[0].getDesc(),
            ),
            SlideTile(
              imagePath: mySLides[1].getImageAssetPath(),
              title: mySLides[1].getTitle(),
              subtitle: mySLides[1].getSubTitle(),
              // desc: mySLides[1].getDesc(),
            ),
            SlideTile(
              imagePath: mySLides[2].getImageAssetPath(),
              title: mySLides[2].getTitle(),
              subtitle: mySLides[2].getSubTitle(),
              // desc: mySLides[2].getDesc(),
            )
          ],
        ),
      ),
      bottomSheet: slideIndex != 2
          ? Container(
              margin: const EdgeInsets.symmetric(vertical: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  MaterialButton(
                    onPressed: () {
                      controller.animateToPage(2,
                          duration: const Duration(milliseconds: 400),
                          curve: Curves.linear);
                    },
                    splashColor: Colors.blue[50],
                    child: const Text(
                      "SKIP",
                      style: TextStyle(
                          color: Color(0xFFBB0F4B),
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                  Row(
                    children: [
                      for (int i = 0; i < 3; i++)
                        i == slideIndex
                            ? _buildPageIndicator(true)
                            : _buildPageIndicator(false),
                    ],
                  ),
                  MaterialButton(
                    onPressed: () {
                      print("this is slideIndex: $slideIndex");
                      controller.animateToPage(slideIndex + 1,
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.linear);
                    },
                    splashColor: Colors.blue[50],
                    child: const Text(
                      "NEXT",
                      style: TextStyle(
                          color: Color(0xFFBB0F4B),
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              ),
            )
          : InkWell(
              onTap: () {
                // stopTimer();
                Navigator.pushReplacementNamed(context, '/welcome_screen');
              //Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){return
              //   Casuler();
              // }));
              },
        child: Container(
          color: Colors.red,
          height: 50,
            width: double.infinity,
            child: Text('go')),
              // child: scounds < 1 ? const Text('Log in ') : Text('Skip |$scounds'),
            ),
    );
  }
}

// ignore: must_be_immutable
class SlideTile extends StatelessWidget {
  String imagePath, title, subtitle;
  SlideTile({super.key, this.imagePath = '', this.title = '', this.subtitle = ''});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 35,
                color: Color(0xFFBB0F4B)),
          ),
          const SizedBox(
            height: 20,
          ),
          Image.asset(imagePath),
          const SizedBox(
            height: 40,
          ),
          Text(
            subtitle,
            textAlign: TextAlign.center,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
          ),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}
