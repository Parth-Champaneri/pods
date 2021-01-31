import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class Comment {
  final String comment;
  final String name;
  final String time;

  Comment({
    @required this.comment,
    @required this.name,
    @required this.time,
  });
}

class DiscusssionBoard extends StatefulWidget {
  final discussion;

  DiscusssionBoard({this.discussion});

  @override
  DiscusssionBoardState createState() => DiscusssionBoardState();
}

class DiscusssionBoardState extends State<DiscusssionBoard> {
  final comments = [
    Comment(
        comment:
            "Hey Reid, I love yout show and this has got to be one of my favourite podcast episodes ever, I've heard it like 5 time. I'm a true fan. Although I do love your commentary, I want to listen to the guests more. Also your transcripts are nice helpful too sometimes, is there no way to put it into the podcasts app? Thank very much, looking forward to your episode with Bill Gates",
        name: 'Ross',
        time: 'Oct 16'),
    Comment(
        comment: "Loved it, great show! want to hear more from Brian!!!",
        name: 'Chandler',
        time: 'Oct 18'),
    Comment(
        comment:
            "AWESOME!! You've gotten me hooked buddy, I love your show. Probably one of the finest productions for a podcast out there. The story telling experience you provide really puts you in a whole different space. I wish there was a way to get episode notes.",
        name: 'Monica',
        time: 'Oct 18'),
    Comment(
        comment:
            "Designing the 10/10 experience part was my favourite, one of the most novel advice I've heard in the entrepreneurship and tech Industry. Also a great first episode to match the show title, Masters of Scale, and then Brians Sacle of Experience... let's call it Brian's SEX! XD",
        name: 'Phebo',
        time: 'Oct 22')
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
                            splashRadius: 1,
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
                                          comment.name,
                                          style: TextStyle(
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                        Text(
                                          comment.time,
                                          style: TextStyle(
                                            fontSize: 11,
                                            color: Colors.grey.shade500,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Container(
                                        child: CommentWidget(
                                            text: comment.comment)),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
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
                                          'Parth Champaneri',
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
                                    Container(
                                        child: TextField(
                                      onSubmitted: (text) {
                                        print(text);
                                      },
                                      decoration: InputDecoration(
                                          hintText: "Your Comment",
                                          border: InputBorder.none),
                                    )),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ]),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _getData() async {
    setState(() {});
  }
}

class CommentWidget extends StatefulWidget {
  final String text;

  CommentWidget({@required this.text});

  @override
  _CommentWidgetState createState() => new _CommentWidgetState();
}

class _CommentWidgetState extends State<CommentWidget> {
  String firstHalf;
  String secondHalf;

  bool flag = true;

  @override
  void initState() {
    super.initState();
    if (widget.text.length > 150) {
      firstHalf = widget.text.substring(0, 150);
      secondHalf = widget.text.substring(150, widget.text.length);
    } else {
      firstHalf = widget.text;
      secondHalf = "";
      flag = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(children: [
        TextSpan(
            text: firstHalf,
            style: TextStyle(
              color: Colors.black,
              fontSize: 14,
            )),
        if (!flag)
          TextSpan(
              text: secondHalf,
              style: TextStyle(
                color: Colors.black,
                fontSize: 14,
              )),
        if (flag)
          TextSpan(
              style: TextStyle(color: Colors.blue),
              text: "...show more",
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  setState(() {
                    flag = false;
                  });
                }),
      ]),
    );
  }
}
