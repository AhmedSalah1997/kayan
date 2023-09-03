
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_grid_view.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_tile.dart';

import '../minor/appbarwidget.dart';

class MoneyToday extends StatefulWidget {

  const MoneyToday(
      {Key? key,})
      : super(key: key);

  @override
  State<MoneyToday> createState() => _MoneyTodayState();
}

class _MoneyTodayState extends State<MoneyToday> {
  @override
  Widget build(BuildContext context) {

    final Stream<QuerySnapshot> _prodcutsStream = FirebaseFirestore.instance
        .collection('moneytoday').snapshots();

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: AppBarTitle( title: 'الأسعار اليومية',),
        backgroundColor: Colors.grey.shade100,
        leading: const AppBarBackButton(),
      ),

      body: StreamBuilder<QuerySnapshot>(
        stream: _prodcutsStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(color: Colors.purple,),);
          }

          if (snapshot.data!.docs.isEmpty) {
            return const Center(child: Text('لا يوجد بيانات \n  حول هذا القسم ',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 26,
                  color: Colors.blueGrey,
                  fontFamily: 'Acme',
                  letterSpacing: 1.5),),);
          }
          return SingleChildScrollView(
            child: StaggeredGridView.countBuilder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: snapshot.data!.docs.length,
              crossAxisCount: 2,
              staggeredTileBuilder: (context) => const StaggeredTile.fit(1),
              itemBuilder: (context, index) {
                return Column(
                 children: [
                   Padding(
                     padding: const EdgeInsets.only(top: 35, right: 15,left: 15),
                     child: Column(
                       mainAxisAlignment: MainAxisAlignment.spaceAround,
                       children: [
                         StaticsModel(
                           label:snapshot.data!.docs[index]['label'] ,
                           value:snapshot.data!.docs[index]['money'] ,
                           decimal:2,
                         ),
                       ],
                     ),
                   )
                 ],
                );
                },
            ),
          );
        },
      ),
    );
  }

}


class StaticsModel extends StatelessWidget {
  final String label;
  final dynamic value;
  final int decimal;
  const StaticsModel(
      {Key? key,
        required this.label,
        required this.value,
        required this.decimal})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 60,
          width: MediaQuery.of(context).size.width * 0.35,
          decoration:  BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25), topRight: Radius.circular(25))),
          child: Center(
              child: Text(
                label,
                textAlign:TextAlign.center,
                style: const TextStyle(color: Colors.black, fontSize: 18,),

              )),
        ),
        Container(
          height: 90,
          width: MediaQuery.of(context).size.width * 0.38,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(25),
                  bottomRight: Radius.circular(25))),
          child: AnimatedCounter(
            count: value,
            decimal: decimal,
          ),
        )
      ],
    );
  }
}

class AnimatedCounter extends StatefulWidget {
  final int decimal;
  final dynamic count;
  const AnimatedCounter({Key? key, required this.count, required this.decimal})
      : super(key: key);

  @override
  State<AnimatedCounter> createState() => _AnimatedCounterState();
}

class _AnimatedCounterState extends State<AnimatedCounter>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation _animation;

  @override
  void initState() {
    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 2));
    _animation = _controller;
    setState(() {
      _animation = Tween(begin: _animation.value, end: widget.count)
          .animate(_controller);
    });
    _controller.forward();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Center(
            child: Text(
              _animation.value.toStringAsFixed(widget.decimal),
              style: const TextStyle(
                  color: Colors.indigo,
                  fontSize: 30,
                  fontFamily: 'Acme',
                  letterSpacing: 2,
                  fontWeight: FontWeight.bold),
            ));
      },
    );
  }
}



class Money extends StatelessWidget {
  const Money({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final Stream<QuerySnapshot> _prodcutsStream = FirebaseFirestore.instance
        .collection('moneytoday').snapshots();

    return StreamBuilder<QuerySnapshot>(
      stream: _prodcutsStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(color: Colors.purple,),);
        }

        if (snapshot.data!.docs.isEmpty) {
          return const Center(child: Text('لا يوجد بيانات \n  حول هذا القسم ',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 26,
                color: Colors.blueGrey,
                fontFamily: 'Acme',
                letterSpacing: 1.5),),);
        }
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              children: [
                // Text(snapshot.data!.docs[3]['label']),
                Container(
                  child: Image.asset('images/more/dollar.jpg'),
                  height: MediaQuery.of(context).size.height*.09,
                  width: MediaQuery.of(context).size.width*.10,
                ),
              Text(snapshot.data!.docs[1]['money'].toString(),style: TextStyle(fontWeight:FontWeight.w600 ),)
              ],
            ),
            Column(
              children: [
                // Text(snapshot.data!.docs[1]['label']),
                Container(
                  child: Image.asset('images/more/golden.jpg'),
                  height: MediaQuery.of(context).size.height*.09,
                  width: MediaQuery.of(context).size.width*.10,
                ),
                Text(snapshot.data!.docs[3]['money'].toString(),style: TextStyle(fontWeight:FontWeight.w600 ),)                ],
            ),
            Column(
              children: [
                // Text(snapshot.data!.docs[2]['label']),
                Container(
                  child: Image.asset('images/more/egg.jpeg'),
                  height: MediaQuery.of(context).size.height*.09,
                  width: MediaQuery.of(context).size.width*.10,
                ),
                Text(snapshot.data!.docs[0]['money'].toString(),style: TextStyle(fontWeight:FontWeight.w600 ),)
              ],
            ),
            Column(
              children: [
                // Text(snapshot.data!.docs[0]['label']),
                Container(
                  child: Image.asset('images/more/chiken.jpg'),
                  height: MediaQuery.of(context).size.height*.09,
                  width: MediaQuery.of(context).size.width*.10,
                ),
                Text(snapshot.data!.docs[4]['money'].toString(),style: TextStyle(fontWeight:FontWeight.w600 ),)     ],
            ),
          ],
        );
      },
    );
  }
}


