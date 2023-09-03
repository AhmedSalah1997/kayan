
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kyan/education/subeducation_prouducts.dart';

const stylee = TextStyle(
  color: Colors.brown,
  fontSize: 16,
  fontWeight: FontWeight.w600,
  letterSpacing: 10,);


class SubEducationModel extends StatelessWidget {
  final String mainCategName;
  final String assetName;
  final String assetImages;
  final String subCategLabel;

  const SubEducationModel({
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
          return SubEducationProducts(
            subCategName: subCategLabel,
            mainCategName: mainCategName,
          );
        }));
      },
      child: Container(
        margin: EdgeInsets.all(10),
        height: MediaQuery.of(context).size.height *.5,
        width: MediaQuery.of(context).size.width *.35,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Colors.white
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image(
                height: MediaQuery.of(context).size.height *.150,
                width: double.infinity,
                image: AssetImage(
                  assetImages,
                ),
                fit: BoxFit.cover,
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
          fontSize: 20,
          fontWeight: FontWeight.bold,
          letterSpacing: 1.5,
        ),
      ),
    );
  }
}



