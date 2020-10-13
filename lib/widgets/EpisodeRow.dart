import '../models/episode.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class EpisodeRowItem extends StatelessWidget {
  final Episode ep;

  EpisodeRowItem(this.ep);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      child: Row(
        children: <Widget>[
          Column(
            children: <Widget>[
              Container(
                height: 50,
                margin: EdgeInsets.all(10),
                // padding: const EdgeInsets.only(top: 20, bottom: 20),
                child: Image.network(
                    'https://content.production.cdn.art19.com/images/26/72/78/e3/267278e3-d103-42af-85f8-ab90ce316661/a8373d5a6e6aeacb4238ce1c0af0198119977ea40db6b0dc470a70a3c352f1fe8880b1cf9aec002793c13dfd03c375ce10804fc0e07bdef7c7ffd870d7742ed8.jpeg',
                    fit: BoxFit.contain),
              ),
            ],
          ),
          Flexible(
            child: Container(
              alignment: Alignment.topLeft,
              child: Text(
                '${ep.title}',
                textAlign: TextAlign.left,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.body2,
              ),
              // padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            ),
          ),
        ],
      ),
    );
  }
}
