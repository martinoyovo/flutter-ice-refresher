import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  ScrollController _listController = ScrollController();
  ScrollController _lController = ScrollController();
  bool _showAppbar = true;
  bool isScrollingDown = false;
  double _containerHeight =  0;

  @override
  void initState() {
    _animationController = AnimationController(
      duration: Duration(milliseconds: 400),
      vsync: this)..repeat();
    print(_animationController.value);
    _listController = ScrollController();
    _lController = ScrollController();
    _listController.addListener(() {
      print(_listController.offset);
    });
    _lController.addListener(() {
      setState(() {
        _containerHeight = _lController.offset;
      });
      print(_containerHeight);
    });
    super.initState();

  }

  @override
  void dispose() {
    _animationController.dispose();
    _listController.dispose();
    _lController.dispose();
    _lController.removeListener(() {});
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: 50,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AnimatedContainer(
                alignment: Alignment.topCenter,
                duration: Duration(milliseconds: 20),
                height: _containerHeight < -23
                    ? -_containerHeight
                    : 23,
                width: 23,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.grey, width: 1.5)
                ),
                child: _containerHeight > -23 ? RotationTransition(
                  alignment: Alignment.center,
                  turns: _animationController,
                  child: Column(
                    children: [
                      Container(
                        height: 2,
                        width: 1,
                        decoration: BoxDecoration(
                            color: Colors.transparent
                        ),
                      ),
                      Container(
                        height: 4,
                        width: 4,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.grey
                        ),
                      ),
                    ],
                  ),
                ): null,
              ),
            ],
          ),
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.symmetric(vertical: 0),
              controller: _lController,
              //controller: _listController,
              physics: BouncingScrollPhysics(),
              shrinkWrap: true,
              itemCount: 20,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Text("$index"),
                );
              }),
          ),
        ],
      ),
    );
  }
}