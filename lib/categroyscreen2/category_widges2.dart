import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../education/subeducation_prouducts.dart';

const stylee = TextStyle(
  color: Colors.brown,
  fontSize: 16,
  fontWeight: FontWeight.w600,
  letterSpacing: 10,);


class SubCategModel2 extends StatelessWidget {
  final String mainCategName;
  final String assetName;
  final String assetImages;
  final String subCategLabel;

  const SubCategModel2({
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
        width:MediaQuery.of(context).size.width *.8,
        height:MediaQuery.of(context).size.height *.3,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.white
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              flex: 1,
              child: ClipRRect(
               borderRadius: BorderRadius.circular(15),
                child: Image(
                  height: MediaQuery.of(context).size.height *.15,
                  width:MediaQuery.of(context).size.width *.8,
                  image: AssetImage(
                    assetImages,
                  ),
                  fit: BoxFit.fill,
                ),
              ),
            ),
            Text(subCategLabel,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold
              ),
              overflow: TextOverflow.ellipsis,maxLines: 1,
            ),
          ],
        ),
      ),
    );
  }
}




