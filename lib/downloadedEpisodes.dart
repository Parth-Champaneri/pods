import 'package:flutter/material.dart';
import 'models/episode.dart';
import 'widgets/EpisodeRow.dart';

class EpisodesList extends StatelessWidget {
  final List<Episode> episodes;

  EpisodesList(this.episodes);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      alignment: Alignment.center,
      child: episodes.isEmpty
          ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  height: 200,
                  child: Image.asset(
                    'assets/images/download.png',
                    // fit: BoxFit.cover,
                  ),
                ),
                Text('No Downloaded Episodes',
                    style: Theme.of(context).textTheme.title),
              ],
            )
          : ListView.builder(
              itemBuilder: (ctx, index) {
                return EpisodeRowItem(episodes[index]);
              },
              itemCount: episodes.length,
            ),
    );
  }
}
