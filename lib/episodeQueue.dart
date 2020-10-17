import 'package:flutter/material.dart';

class QueueList extends StatefulWidget {
  @override
  _QueueListState createState() => _QueueListState();
}

class _QueueListState extends State<QueueList> {
  final myItems = ['parth', 'jui'];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        child: ReorderableListView(
          onReorder: (oldIndex, newIndex) {
            setState(() {
              _onReorder(oldIndex, newIndex);
            });
          },
          children: [
            for (final item in myItems)
              ListTile(
                key: ValueKey(item),
                title: Text('${item}'),
              )
          ],
        ),
      ),
    );
  }

  void _onReorder(int oldIndex, int newIndex) {
    setState(
      () {
        if (newIndex > oldIndex) {
          newIndex -= 1;
        }
        final String item = myItems.removeAt(oldIndex);
        myItems.insert(newIndex, item);
      },
    );
  }
}
