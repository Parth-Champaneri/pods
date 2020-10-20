import 'package:flutter/material.dart';

class SliversExample extends StatelessWidget {
  SliversExample();

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: SafeArea(
          child: CustomScrollView(
            slivers: [
              SliverAppBar(
                backgroundColor: Colors.white,
                title: Container(
                  color: Colors.white,
                  padding: EdgeInsets.only(left: 20, right: 20),
                  child: TextField(
                    textAlignVertical: TextAlignVertical.center,
                    decoration: InputDecoration(
                        prefixIcon: Icon(Icons.search),
                        filled: true,
                        fillColor: Colors.white,
                        hintText: 'Search Podcasts',
                        hintStyle: TextStyle(color: Colors.black38),
                        contentPadding:
                            EdgeInsets.only(top: 5, bottom: 5, left: 7)),
                  ),
                ),
              ),
              SliverGrid(
                gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 300.0,
                  mainAxisSpacing: 10.0,
                  crossAxisSpacing: 10.0,
                  childAspectRatio: 1.0,
                ),
                delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                    return Container(
                        alignment: Alignment.center,
                        child: Image.network(
                            "https://content.production.cdn.art19.com/images/69/6e/7c/4a/696e7c4a-a7e8-4fb4-8a6f-e9eea70fa13c/9438806119cac21fa439cb167eb3ede90a2fb3e04c2b42f434fc6393a9008ceefd466aa848fa137033393fc3051355d989756de55b9edf5e9b1333687010249b.jpeg"));
                  },
                  childCount: 4,
                ),
              ),
            ],
          ),
        ));
  }
}
