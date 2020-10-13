import 'package:flutter/material.dart';
import 'package:share/share.dart';

class SearchWidget extends StatelessWidget {
  SearchWidget();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              color: Colors.white,
              padding: EdgeInsets.only(left: 20, right: 20),
              child: TextField(
                style: TextStyle(color: Colors.black38),
                decoration: InputDecoration(
                    border: InputBorder.none,
                    filled: true,
                    fillColor: Colors.black12,
                    hintText: 'Search Podcasts',
                    hintStyle: TextStyle(color: Colors.black38)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
