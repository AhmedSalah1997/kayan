import 'package:flutter/material.dart';

class AppBarBackButton extends StatelessWidget {
  const AppBarBackButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed:(){
        Navigator.pop(context);
      } ,
      icon: const Icon(Icons.arrow_back_ios_new , color: Colors.black,),
    );
  }
}


class YellowBackButton extends StatelessWidget {
  const YellowBackButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed:(){
        Navigator.pop(context);
      } ,
      icon: const Icon(Icons.arrow_back_ios_new , color: Colors.yellow,),
    );
  }
}

class AppBarTitle extends StatelessWidget {
  final String title;

  const AppBarTitle({
    Key? key,
    required this.title,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(color: Colors.indigo,fontSize: 20 , fontWeight: FontWeight.bold),
    );
  }
}