
import 'package:flutter/material.dart';
import 'package:kyan/slider/product_slider.dart';



class ShowSlider extends StatefulWidget {
  final dynamic slider ;
  const ShowSlider({
    Key? key,
    required this.slider
  }) : super(key: key);

  @override
  State<ShowSlider> createState() => _ShowSliderState();
}

class _ShowSliderState extends State<ShowSlider> {


  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>  ProductSliderSecreen(slider: widget.slider,)));
      },
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Container(
          width: double.infinity,
          // height: MediaQuery.of(context).size.height *0.9,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10)
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Expanded(
                flex: 1,
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(topLeft:Radius.circular(15),topRight:Radius.circular(15) ),
                  child: Image.network(widget.slider['proimage'][0],
                    // height: MediaQuery.of(context).size.height *0.4,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Text(widget.slider['text']),
            ],
          ),
        ),
      )
    );
  }
}



