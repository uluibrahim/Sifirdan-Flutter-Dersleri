import 'dart:ui';

import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      body: Column(
        children: [
          kaydirmaliBar(context),
          Expanded(
            child: cardListView(),
          )
        ],
      ),
    );
  }

  ListView cardListView() {
    return ListView(children: [
      Padding(
        padding: EdgeInsets.all(16),
        child: Material(
          elevation: 10,

          //color: Colors.cyan,
          borderRadius: BorderRadius.all(Radius.circular(20)),
          child: Container(
            height: 500,
            child: Column(
              children: [
                Expanded(
                  flex: 15,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: buildListtile(),
                  ),
                ),
                Expanded(
                  flex: 17,
                  child: Container(
                    //color: Colors.green,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                          "Abdlclksdiklcsdilkvnsldknvlksdnvlkskdnvlkdnkdnvlklssdnvsnkvsndvsdnkv<lhscbkjbcş<dncl<dsncil<ldsnclkdnclk<dscnlkş<snclksndclkns<ckns<ldkcn<sdncsn"),
                    ),
                  ),
                ),
                Expanded(
                  flex: 68,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GestureDetector(
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                                image: DecorationImage(
                                  fit: BoxFit.fill,
                                  image: AssetImage(
                                    "assets/images/modelgrid1.jpeg",
                                  ),
                                ),
                              ),
                            ),
                            onTap: () {},
                          ),
                        ),
                      ),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: GestureDetector(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(20)),
                                      image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: AssetImage(
                                          "assets/images/modelgrid2.jpeg",
                                        ),
                                      ),
                                    ),
                                  ),
                                  onTap: () {},
                                ),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: GestureDetector(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(20)),
                                      image: DecorationImage(
                                        fit: BoxFit.fill,
                                        image: AssetImage(
                                          "assets/images/modelgrid3.jpeg",
                                        ),
                                      ),
                                    ),
                                  ),
                                  onTap: () {},
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ]);
  }

  ListTile buildListtile() {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: AssetImage("assets/images/model1.jpeg"),
        radius: 40,
      ),
      title: Text("Daisy"),
      subtitle: Text("34 mins ago"),
      trailing: Icon(Icons.more_vert),
    );
  }

  Container kaydirmaliBar(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.25,
      width: MediaQuery.of(context).size.width,
      //color: Colors.white,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          _listeElemanlari(
            "assets/images/model1.jpeg",
            "assets/images/chanellogo.jpg",
          ),
          _listeElemanlari(
            "assets/images/model2.jpeg",
            "assets/images/chloelogo.png",
          ),
          _listeElemanlari(
            "assets/images/model3.jpeg",
            "assets/images/louisvuitton.jpg",
          ),
          _listeElemanlari(
            "assets/images/model1.jpeg",
            "assets/images/chanellogo.jpg",
          ),
          _listeElemanlari(
            "assets/images/model2.jpeg",
            "assets/images/chloelogo.png",
          ),
          _listeElemanlari(
            "assets/images/model3.jpeg",
            "assets/images/louisvuitton.jpg",
          ),
        ],
      ),
    );
  }

  AppBar appBar() {
    return AppBar(
      title: Text(
        'Moda Alışveriş',
        style: TextStyle(color: Colors.black, fontFamily: "Montserrat"),
      ),
      backgroundColor: Colors.transparent,
      elevation: 0,
      actions: [
        IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.photo_camera_outlined,
              color: Colors.indigo,
            )),
      ],
    );
  }

  _listeElemanlari(String s, String t) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Stack(
            //alignment: Alignment.bottomRight, // sadece 2 eleman olduğunda kullanışlı bir yapıdır
            children: [
              CircleAvatar(
                backgroundImage: AssetImage(s),
                radius: 45,
              ),
              Positioned(
                top: 53,
                left: 53,
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  backgroundImage: AssetImage(t),
                  radius: 18,
                ),
              ),
            ],
          ),
        ),
        ElevatedButton(
          onPressed: () {},
          child: Text("Fallow "),
          style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20)))),
        )
      ],
    );
  }
}
