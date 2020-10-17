import 'package:flutter/material.dart';

class DiscusssionBoard extends StatefulWidget {
  final discussion;

  DiscusssionBoard({this.discussion});

  @override
  DiscusssionBoardState createState() => DiscusssionBoardState();
}

class DiscusssionBoardState extends State<DiscusssionBoard> {
  final comments = [
    "Comment 1, this is just a test and this is an extremely long comment for absolutely no reason. And now I'm just rambling on for absolutely no reason Comment 1, this is just a test and this is an extremely long comment for absolutely no reason. And now I'm just rambling on for absolutely no reason  this is just a test and this is an extremely long comment for absolutely no reason. And now I'm just rambling on for absolutely no reason Comment 1, this is just a test and this is an extremely long comment for absolutely no reason. And now I'm just rambling on for absolutely no reason ",
    'Comment 2, this is just another test',
    'http://www.google.com'
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: RefreshIndicator(
        displacement: 10,
        onRefresh: _getData,
        child: ListView(
          children: [
            Container(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    for (final comment in comments)
                      Container(
                        padding: EdgeInsets.all(10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CircleAvatar(
                              radius: 15,
                            ),
                            Expanded(
                              child: Container(
                                padding: EdgeInsets.only(left: 10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Name',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          'Mon Oct 23 2020',
                                          style: TextStyle(
                                            fontSize: 11,
                                            color: Colors.grey.shade500,
                                          ),
                                        ),
                                      ],
                                    ),
                                    DescriptionTextWidget(text: comment),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                  ]),
            )
          ],
        ),
      ),
    );
  }

  Future<void> _getData() async {
    setState(() {});
  }
}

class DescriptionTextWidget extends StatefulWidget {
  final String text;

  DescriptionTextWidget({@required this.text});

  @override
  _DescriptionTextWidgetState createState() =>
      new _DescriptionTextWidgetState();
}

class _DescriptionTextWidgetState extends State<DescriptionTextWidget> {
  String firstHalf;
  String secondHalf;

  bool flag = true;

  @override
  void initState() {
    super.initState();

    if (widget.text.length > 300) {
      firstHalf = widget.text.substring(0, 300);
      secondHalf = widget.text.substring(300, widget.text.length);
    } else {
      firstHalf = widget.text;
      secondHalf = "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return secondHalf.isEmpty
        ? new Text(firstHalf)
        : new Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              new Text(flag ? (firstHalf + "...") : (firstHalf + secondHalf)),
              new InkWell(
                child: new Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    new Text(
                      flag ? "show more" : "show less",
                      style: new TextStyle(color: Colors.blue),
                    ),
                  ],
                ),
                onTap: () {
                  setState(() {
                    flag = !flag;
                  });
                },
              ),
            ],
          );
  }
}
