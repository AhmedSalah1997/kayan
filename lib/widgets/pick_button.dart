import 'package:flutter/material.dart';

class PinkButton extends StatelessWidget {
  final String lable ;
  final Function() onPress;
  final double width;
  const PinkButton({
    Key? key,
    required this.lable, required this.onPress, required this.width
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Container(
      height: 45,
      width: MediaQuery.of(context).size.width*width,
      decoration: BoxDecoration(
        color: Colors.pink.shade400,
        borderRadius: BorderRadius.circular(12),
      ),
      child: MaterialButton(
        onPressed: onPress,
        child:  Text(lable,style:const TextStyle(
          color: Colors.white
        ),),
      ),
    );
  }
}