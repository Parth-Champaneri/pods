import 'package:flutter/material.dart';

class PodFeed extends StatefulWidget {
  @override
  _PodFeedState createState() => _PodFeedState();
}

class _PodFeedState extends State<PodFeed> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: RefreshIndicator(
        onRefresh: _getData,
        child: Container(
          padding: EdgeInsets.all(10),
          child: ListView(children: [
            Row(
              children: [
                Text(
                  "Latest Updates",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontFamily: "San Fransisco",
                    fontSize: 28,
                  ),
                ),
              ],
            ),
            // Container(
            //   color: Colors.black,
            //   decoration: new BoxDecoration(
            //       color: Colors.black,
            //       image: DecorationImage(
            //         image: ImageProvider(
            //           child: Image.network(
            //               "https://content.production.cdn.art19.com/images/69/6e/7c/4a/696e7c4a-a7e8-4fb4-8a6f-e9eea70fa13c/9438806119cac21fa439cb167eb3ede90a2fb3e04c2b42f434fc6393a9008ceefd466aa848fa137033393fc3051355d989756de55b9edf5e9b1333687010249b.jpeg"),
            //         ),
            //       )),
            //   margin: EdgeInsets.symmetric(vertical: 10),
            //   child: Row(children: [
            //     Expanded(
            //       child: Image.network(
            //           "https://content.production.cdn.art19.com/images/69/6e/7c/4a/696e7c4a-a7e8-4fb4-8a6f-e9eea70fa13c/9438806119cac21fa439cb167eb3ede90a2fb3e04c2b42f434fc6393a9008ceefd466aa848fa137033393fc3051355d989756de55b9edf5e9b1333687010249b.jpeg"),
            //     ),
            //   ]),
            // ),
            Stack(alignment: Alignment.bottomLeft, children: [
              Row(children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Episode 1: Jordan Harbinger Show",
                      ),
                      ColorFiltered(
                        colorFilter: ColorFilter.mode(
                          Colors.black.withOpacity(0.6),
                          BlendMode.darken,
                        ),
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 5),
                          child: Image.network(
                              "https://img.podcastone.com/images/1237/harbinger-pc1logo.png"),
                        ),
                      ),
                      // Container(
                      //   padding: EdgeInsets.symmetric(vertical: 51),
                      //   decoration: BoxDecoration(
                      //     gradient: LinearGradient(
                      //       begin: Alignment.topCenter,
                      //       end: Alignment.bottomCenter,
                      //       colors: [Colors.black, Colors.transparent],
                      //       stops: [0.0, 0.5],
                      //     ),
                      //   ),
                      //   child: Image.network(
                      //       "https://img.podcastone.com/images/1237/harbinger-pc1logo.png"),
                      // ),
                    ],
                  ),
                ),
              ]),
              Container(
                margin: EdgeInsets.only(bottom: 10, left: 10),
                child: Text(
                  "Hi there",
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),
            ]),
            Row(children: [
              Expanded(
                child: Image.network(
                    "https://content.production.cdn.art19.com/images/69/6e/7c/4a/696e7c4a-a7e8-4fb4-8a6f-e9eea70fa13c/9438806119cac21fa439cb167eb3ede90a2fb3e04c2b42f434fc6393a9008ceefd466aa848fa137033393fc3051355d989756de55b9edf5e9b1333687010249b.jpeg"),
              ),
            ]),
            Row(children: [
              Expanded(
                child: Image.network(
                    "https://content.production.cdn.art19.com/images/01/1b/f3/d6/011bf3d6-a448-4533-967b-e2f19e376480/c81936f538106550b804e7e4fe2c236319bab7fba37941a6e8f7e5c3d3048b88fc5b2182fb790f7d446bdc820406456c94287f245db89d8656c105d5511ec3de.jpeg"),
              ),
            ]),
            Row(children: [
              Expanded(
                child: Image.network(
                    "https://media.npr.org/assets/img/2018/08/02/npr_planetmoney_podcasttile_sq-7b7fab0b52fd72826936c3dbe51cff94889797a0.jpg?s=1400"),
              ),
            ]),
          ]),
        ),
      ),
    );
  }

  Future<void> _getData() async {
    setState(() {});
  }
}
