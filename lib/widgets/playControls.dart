import 'package:flutter/material.dart';

class PlayerButtons extends StatelessWidget {
  final Icon icon;

  PlayerButtons({this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: IconButton(
        onPressed: () {},
        splashRadius: null,
        icon: this.icon,
        iconSize: 32,
        color: Theme.of(context).primaryColor,
      ),
    );
  }
}
