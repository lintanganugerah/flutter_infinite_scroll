import 'dart:ffi';

import 'package:flutter/material.dart';

class Infinitescrollscreen extends StatefulWidget {
  @override
  State<Infinitescrollscreen> createState() => _InfinitescrollscreenState();
}

class _InfinitescrollscreenState extends State<Infinitescrollscreen> {
  final _scrollController = ScrollController();
  final List<int> _listItems = listGenerator();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_loadMore);
  }

  void _loadMore() {
    if(_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
      setState(() {
        _listItems.addAll(listGenerator(_listItems));
      });
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Infinite Scrolling', style: TextStyle(fontSize: 12, color: Colors.white),),
        backgroundColor: Colors.blueAccent,
        centerTitle: true,
      ),
      body: ListView.builder(
          controller: _scrollController,
          itemCount: _listItems.length,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              height: 250,
              decoration: BoxDecoration(
                  color: Colors.grey,
                  border: Border.all(color: Colors.black)
              ),
              child: Center(child: Text("${_listItems[index]}", textAlign: TextAlign.center, style: TextStyle(fontSize: 50))),
            );
          }
      ),
    );
  }
}

List<int> listGenerator([List<int>? lastList]) {
  int lastNumberOnPrevList = 0;

  if(lastList != null && lastList.isNotEmpty) {
    lastNumberOnPrevList = lastList.last + 1;
  }

  return List.generate(10, (int index) => lastNumberOnPrevList + index);
}