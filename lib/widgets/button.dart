import 'package:flutter/material.dart';

class YellowButton extends StatelessWidget {
  final String lable ;
  final Function() onPress;
  final double width;
  const YellowButton({
    Key? key,
    required this.lable, required this.onPress, required this.width
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Container(
      height: 40,
      width: MediaQuery.of(context).size.width*width,
      decoration: BoxDecoration(
        color: Colors.yellow,
        borderRadius: BorderRadius.circular(25),
      ),
      child: MaterialButton(
        onPressed: onPress,
        child:  Text(lable),
      ),
    );
  }
}