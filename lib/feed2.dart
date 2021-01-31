import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class PodFeedSmall extends StatefulWidget {
  @override
  _PodFeedSmallState createState() => _PodFeedSmallState();
}

class _PodFeedSmallState extends State<PodFeedSmall> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: RefreshIndicator(
        onRefresh: _getData,
        child: ListView(children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 8, vertical: 15),
            child: Column(
              children: [
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("The Jordan Harbinger Show"),
                      Text("Oct 22 2020"),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 5),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 125,
                        child: CachedNetworkImage(
                          imageUrl:
                              "https://img.podcastone.com/images/1237/harbinger-pc1logo.png",
                          placeholder: (context, url) =>
                              CircularProgressIndicator(),
                          errorWidget: (context, url, error) =>
                              Icon(Icons.error),
                        ),
                        // child: Image.network(
                        //     "https://img.podcastone.com/images/1237/harbinger-pc1logo.png"),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              padding: EdgeInsets.only(left: 10, bottom: 10),
                              child: Text(
                                "22. History of Podcasting",
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(left: 10),
                              child: Text(
                                "This episode is about the story of Airbnb. How they went from handcrafting breakfast cereal to a multi-billion dollar company in the travel industry. Brian talks about a concept of 'the magic wand' experience. Designing the best 12/10 experience for your customer and then working back to what is acheivable.",
                                maxLines: 4,
                                overflow: TextOverflow.ellipsis,
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: 125,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Icon(Icons.favorite_border),
                            Icon(Icons.comment_bank_outlined),
                            Icon(Icons.ios_share),
                          ],
                        ),
                      ),
                      Container(
                        width: 125,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Icon(null),
                            Icon(Icons.play_arrow_rounded),
                            Icon(Icons.download_done_outlined),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 8, vertical: 15),
            child: Column(
              children: [
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Masters of Scale"),
                      Text("Oct 18 2020"),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 5),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => EpisodePage()));
                        },
                        child: Container(
                          width: 125,
                          child: Hero(
                            tag: 'dash',
                            child: Image.network(
                                "https://content.production.cdn.art19.com/images/69/6e/7c/4a/696e7c4a-a7e8-4fb4-8a6f-e9eea70fa13c/9438806119cac21fa439cb167eb3ede90a2fb3e04c2b42f434fc6393a9008ceefd466aa848fa137033393fc3051355d989756de55b9edf5e9b1333687010249b.jpeg"),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              padding: EdgeInsets.only(left: 10),
                              child: Hero(
                                tag: 'title',
                                child: Text(
                                  "1. Handcrafted with Brian Chesky of Airbnb",
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(left: 10),
                              child: Text(
                                "This episode is about the story of Airbnb. How they went from handcrafting breakfast cereal to a multi-billion dollar company in the travel industry. Brian talks about a concept of 'the magic wand' experience. Designing the best 12/10 experience for your customer and then working back to what is acheivable.",
                                maxLines: 4,
                                overflow: TextOverflow.ellipsis,
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: 125,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Icon(Icons.favorite_border),
                            Icon(Icons.comment_bank_outlined),
                            Icon(Icons.ios_share),
                          ],
                        ),
                      ),
                      Container(
                        width: 125,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Icon(null),
                            Icon(Icons.play_arrow_rounded),
                            Icon(Icons.download_done_outlined),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 8, vertical: 15),
            child: Column(
              children: [
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Economics of Entrepreneurship"),
                      Text("Oct 22 2020"),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 5),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 125,
                        child: Image.network(
                            "https://media.npr.org/assets/img/2018/08/02/npr_planetmoney_podcasttile_sq-7b7fab0b52fd72826936c3dbe51cff94889797a0.jpg?s=1400"),
                      ),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              padding: EdgeInsets.only(left: 10),
                              child: Text(
                                "1. Handcrafted with Brian Chesky of Airbnb",
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(left: 10),
                              child: Text(
                                "This episode is about the story of Airbnb. How they went from handcrafting breakfast cereal to a multi-billion dollar company in the travel industry. Brian talks about a concept of 'the magic wand' experience. Designing the best 12/10 experience for your customer and then working back to what is acheivable.",
                                maxLines: 4,
                                overflow: TextOverflow.ellipsis,
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: 125,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Icon(Icons.favorite_border),
                            Icon(Icons.comment_bank_outlined),
                            Icon(Icons.ios_share),
                          ],
                        ),
                      ),
                      Container(
                        width: 125,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Icon(null),
                            Icon(Icons.play_arrow_rounded),
                            Icon(Icons.download_done_outlined),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 8, vertical: 15),
            child: Column(
              children: [
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("The Jordan Harbinger Show"),
                      Text("Oct 22 2020"),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 5),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 125,
                        child: Image.network(
                            "https://img.podcastone.com/images/1237/harbinger-pc1logo.png"),
                      ),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              padding: EdgeInsets.only(left: 10),
                              child: Text(
                                "1. Handcrafted with Brian Chesky of Airbnb",
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black,
                                  decoration: TextDecoration.none,
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(left: 10),
                              child: Text(
                                "This episode is about the story of Airbnb. How they went from handcrafting breakfast cereal to a multi-billion dollar company in the travel industry. Brian talks about a concept of 'the magic wand' experience. Designing the best 12/10 experience for your customer and then working back to what is acheivable.",
                                maxLines: 4,
                                overflow: TextOverflow.ellipsis,
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: 125,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Icon(Icons.favorite_border),
                            Icon(Icons.comment_bank_outlined),
                            Icon(Icons.ios_share),
                          ],
                        ),
                      ),
                      Container(
                        width: 125,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Icon(null),
                            Icon(Icons.play_arrow_rounded),
                            Icon(Icons.download_done_outlined),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          )
        ]),
      ),
    );
  }

  Future<void> _getData() async {
    setState(() {});
  }
}

class EpisodePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        brightness: Brightness.light,
        elevation: 0.0,
        centerTitle: false,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.grey[900]),
        title: Text(
          "Explore",
          style: Theme.of(context).textTheme.headline1,
          // style: TextStyle(
          //   color: Colors.black,
          //   fontWeight: FontWeight.w500,
          //   fontSize: 24,
          // ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Container(
            padding: EdgeInsets.only(left: 8),
            child: Icon(Icons.arrow_back_ios)),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(10),
          child: ListView(
            children: [
              Hero(
                tag: 'dash',
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    'https://content.production.cdn.art19.com/images/69/6e/7c/4a/696e7c4a-a7e8-4fb4-8a6f-e9eea70fa13c/9438806119cac21fa439cb167eb3ede90a2fb3e04c2b42f434fc6393a9008ceefd466aa848fa137033393fc3051355d989756de55b9edf5e9b1333687010249b.jpeg',
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 10),
                child: Text(
                  "1. Handcrafted with Brian Chesky of Airbnb",
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  style: TextStyle(
                    fontSize: 22,
                    color: Colors.black,
                    decoration: TextDecoration.none,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
