import 'package:flutter/material.dart';

class PageViewKullanimi extends StatefulWidget {
  PageViewKullanimi(Key key) : super(key: key);

  @override
  _PageViewKullanimiState createState() => _PageViewKullanimiState();
}

class _PageViewKullanimiState extends State<PageViewKullanimi> {
  var myController =
      PageController(keepPage: true, initialPage: 0, viewportFraction: 1);
  bool eksen = true;
  bool snapping = true;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: PageView(
            controller: myController,
            scrollDirection: eksen == true ? Axis.horizontal : Axis.vertical,
            pageSnapping: snapping,
            onPageChanged: (value) {
              print("index $value");
            },
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 200,
                  color: Colors.red,
                  child: Align(child: Text("Sayfa")),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 200,
                  color: Colors.green,
                  child: Align(child: Text("Sayfa")),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: Container(
            color: Colors.white54,
            height: 200,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    children: [
                      Text("Kaydırma ekseni yatay"),
                      Checkbox(
                        value: eksen,
                        onChanged: (value) {
                          setState(() {
                            eksen = value!;
                          });
                        },
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    children: [
                      Text("Page snapping"),
                      Checkbox(
                        value: snapping,
                        onChanged: (value) {
                          setState(() {
                            snapping = value!;
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
