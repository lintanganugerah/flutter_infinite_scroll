import 'package:flutter/material.dart';

class FiniteScrollScreen10 extends StatelessWidget {
  final List<int> numberList = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Finite Scroll (10 Items)', style: TextStyle(fontSize: 12, color: Colors.white),),
        backgroundColor: Colors.blueAccent,
        centerTitle: true,
      ),
      body: ListView.builder(
          itemCount: numberList.length,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              height: 250,
              decoration: BoxDecoration(
                  color: Colors.grey,
                  border: Border.all(color: Colors.black)
              ),
              child: Center(child: Text("${numberList[index]}", textAlign: TextAlign.center, style: TextStyle(fontSize: 50))),
            );
          }
      ),
    );
  }
}