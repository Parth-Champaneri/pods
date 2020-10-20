import 'package:flutter/material.dart';

class DiscusssionBoard extends StatefulWidget {
  final discussion;

  DiscusssionBoard({this.discussion});

  @override
  DiscusssionBoardState createState() => DiscusssionBoardState();
}

class DiscusssionBoardState extends State<DiscusssionBoard> {
  final comments = [
    "Hey Reid, I love yout show and this has got to be one of my favourite podcast episodes ever, I've heard it like 5 time. I'm a true fan. Although I do love your commentary, I want to listen to the guests more. Also your transcripts are nice helpful too sometimes, is there no way to put it into the podcasts app? Thank very much, looking forward to your episode with Bill Gates",
    'Loved it, great show! want to hear more from Brian!!!',
    "AWESOME!! You've gotten me hooked buddy, I love your show. Probably one of the finest productions for a podcast out there. The story telling experience you provide really puts you in a whole different space. I wish there was a way to get episode notes.",
    "Designing the 10/10 experience part was my favourite, one of the most novel advice I've heard in the entrepreneurship and tech Industry. Also a great first episode to match the show title, Masters of Scale, and then Brians Sacle of Experience... let's call it Brian's SEX! XD",
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
              padding: EdgeInsets.all(12),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.only(top: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image.network(
                            "https://content.production.cdn.art19.com/images/69/6e/7c/4a/696e7c4a-a7e8-4fb4-8a6f-e9eea70fa13c/9438806119cac21fa439cb167eb3ede90a2fb3e04c2b42f434fc6393a9008ceefd466aa848fa137033393fc3051355d989756de55b9edf5e9b1333687010249b.jpeg",
                            height: 80,
                          ),
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.only(left: 10),
                              child: Text(
                                "1. Handcrafted with Brian Chesky of Airbnb",
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.play_circle_fill_rounded,
                              color: Theme.of(context).primaryColorDark,
                            ),
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.ios_share,
                              color: Theme.of(context).primaryColorDark,
                            ),
                          ),
                        ],
                      ),
                    ),
                    for (final comment in comments)
                      Container(
                        padding: EdgeInsets.symmetric(vertical: 7),
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
                                            fontWeight: FontWeight.w700,
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
