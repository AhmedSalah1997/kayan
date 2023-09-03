import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../minor/sub_category_secreen.dart';

const stylee = TextStyle(
    color: Colors.brown,
    fontSize: 16,
    fontWeight: FontWeight.w600,
    letterSpacing: 10,);


class SubCategModel extends StatelessWidget {
  final String mainCategName;
  final String assetName;
  final String assetImages;
  final String subCategLabel;

  const SubCategModel({
    Key? key,
    required this.mainCategName,
    required this.assetImages,
    required this.assetName,
    required this.subCategLabel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return SubCategoProdutes(
            subCategName: subCategLabel,
            mainCategName: mainCategName,
          );
        }));
      },
      child: Column(
        children: [
          SizedBox(
            height: 70,
            width: 70,
            child: Image(
              image: AssetImage(
                assetImages,
              ),
            ),
          ),
          Text(subCategLabel,
            style: const TextStyle(
              fontSize: 15,
            ),
            //overflow: TextOverflow.ellipsis,maxLines: 1,
            ),
        ],
      ),
    );
  }
}

class CategHedaerLabel extends StatelessWidget {
  final String headerLabel;

  const CategHedaerLabel({Key? key, required this.headerLabel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(30.0),
      child: Text(
        headerLabel,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          letterSpacing: 1.5,
        ),
      ),
    );
  }
}

class TextKyan extends StatelessWidget {
  final String text ;
  const TextKyan({
    Key? key,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(text,
        style: TextStyle(
          fontSize: 11,
          color: Colors.white
        ),
      ),
    );
  }
}

class KyanDesc extends StatelessWidget {
  const KyanDesc({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height *0.29,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(.7),
        // borderRadius: BorderRadius.circular(10)
      ),
      child:  Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                ' kyan ',
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 17,
                    fontWeight: FontWeight.w600),
              ),
              TextKyan(text: '  Whatsapp : 01090643343  '),
              TextKyan(text: ' Phone No '),
              TextKyan(text: ' 01090643343 '),
              TextKyan(text: ' 01069958644 '),
              TextKyan(text: ' 0504850778 '),
              TextKyan(text: ' الدقهلية - تمي الامديد - حي السلام  '),
              TextKyan(text: ' info@kyan.online '),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                ' Services ',
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 17,
                    fontWeight: FontWeight.w600),
              ),
              TextKyan(text: ' خدمة الشحن '),
              TextKyan(text: ' خدمات الطالب  '),
              TextKyan(text: ' التسوق والمطاعم '),
              TextKyan(text: ' الخدمات الطبية '),
              TextKyan(text: ' طور نفسك '),
            ],
          ),

        ],
      ),
    );
  }
}





