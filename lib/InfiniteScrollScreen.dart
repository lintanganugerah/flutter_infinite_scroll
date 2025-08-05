import 'package:flutter/material.dart';

class InfiniteScrollScreen extends StatefulWidget {
  @override
  State<InfiniteScrollScreen> createState() => _InfiniteScrollScreenState();
}

class _InfiniteScrollScreenState extends State<InfiniteScrollScreen> {
  final _scrollController = ScrollController();
  final List<int> _listItems = listGenerator();
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_loadMore);
  }

  void _loadMore() async {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      //Set Loading
      setState(() {
        isLoading = true;
      });

      //Tambahkan delay agar terlihat loading nya (Simulasi fetch API)
      await Future.delayed(Duration(seconds: 3));

      setState(() {
        _listItems.addAll(listGenerator(_listItems));
        isLoading = false;
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
        title: Text(
          'Infinite Scrolling',
          style: TextStyle(fontSize: 12, color: Colors.white),
        ),
        backgroundColor: Colors.blueAccent,
        centerTitle: true,
      ),
      body: ListView.builder(
        controller: _scrollController,
        itemCount: _listItems.length + (isLoading ? 1 : 0),
        itemBuilder: (BuildContext context, int index) {
          if (index < _listItems.length) {
            return Container(
              height: 250,
              decoration: BoxDecoration(
                color: Colors.grey,
                border: Border.all(color: Colors.black),
              ),
              child: Center(
                child: Text(
                  "${_listItems[index]}",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 50),
                ),
              ),
            );
          } else {
            return Padding(
              padding: EdgeInsets.symmetric(vertical: 16),
              child: Center(child: CircularProgressIndicator()),
            );
          }
        },
      ),
    );
  }
}

List<int> listGenerator([List<int>? lastList]) {
  int lastNumberOnPrevList = 0;

  if (lastList != null && lastList.isNotEmpty) {
    lastNumberOnPrevList = lastList.last + 1;
  }

  return List.generate(10, (int index) => lastNumberOnPrevList + index);
}
