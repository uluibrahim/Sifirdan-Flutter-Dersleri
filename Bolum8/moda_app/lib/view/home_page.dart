import 'dart:ui';

import 'package:flutter/material.dart';

import 'detay.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  bool fav = false;
  double opacityFav = 0.2;
  TabController? tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    tabController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Material(
        //color: Colors.blue,
        child: TabBar(
          labelColor: Colors.black87,
          controller: tabController,
          unselectedLabelColor: Colors.black87.withOpacity(0.3),
          tabs: [
            Tab(
              icon: Icon(Icons.home),
              text: "sdcdsc",
            ),
            Tab(
              icon: Icon(Icons.play_arrow),
              text: "sdcdccsc",
            ),
            Tab(
              icon: Icon(Icons.navigation),
              text: "sdcdsc",
            ),
            Tab(
              icon: Icon(Icons.account_circle_outlined),
              text: "sdcdccsc",
            ),
          ],
        ),
      ),
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
          child: cardListViewContainer(),
        ),
      ),
    ]);
  }

  Container cardListViewContainer() {
    return Container(
      height: 500,
      child: Column(
        children: [
          Expanded(
            flex: 12,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: buildListtile(),
            ),
          ),
          Expanded(flex: 15, child: textContainer()),
          Expanded(flex: 60, child: rowImage()),
          Expanded(flex: 13, child: hastagRow()),
          Expanded(flex: 2, child: divider()),
          Expanded(flex: 10, child: cardTabRow()),
        ],
      ),
    );
  }

  Row cardTabRow() {
    return Row(
      children: [
        Container(
          child: Row(
            children: [
              IconButton(onPressed: () {}, icon: Icon(Icons.share)),
              Text("1.7 k"),
            ],
          ),
        ),
        SizedBox(
          width: 20,
        ),
        Container(
          child: Row(
            children: [
              IconButton(onPressed: () {}, icon: Icon(Icons.comment)),
              Text("300"),
            ],
          ),
        ),
        SizedBox(
          width: 20,
        ),
        Container(
          child: Row(
            children: [
              IconButton(
                  onPressed: () {
                    setState(() {
                      fav == false ? fav = true : fav = false;
                      if (fav == false) {
                        opacityFav = 0.1;
                      } else {
                        opacityFav = 1;
                      }
                    });
                  },
                  icon: Icon(
                    Icons.favorite,
                    color: Colors.red.withOpacity(opacityFav),
                  )),
              Text("142"),
            ],
          ),
        ),
      ],
    );
  }

  Divider divider() => Divider(thickness: 1.5, endIndent: 40, indent: 40);

  Row hastagRow() {
    return Row(
      children: [
        SizedBox(width: 30),
        Container(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text("#Louis Vuitton"),
          ),
          decoration: BoxDecoration(
            color: Colors.brown.withOpacity(0.3),
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
        ),
        SizedBox(width: 30),
        Container(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text("#Louis Vuitton"),
          ),
          decoration: BoxDecoration(
            color: Colors.brown.withOpacity(0.3),
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
        ),
      ],
    );
  }

  Row rowImage() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: modelBirContainer(),
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
                  child: modelIkiContainer(),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: modelUcContainer(),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  InkWell modelUcContainer() {
    return InkWell(
      child: Hero(
        tag: "assets/images/modelgrid3.jpeg",
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            image: DecorationImage(
              fit: BoxFit.fill,
              image: AssetImage(
                "assets/images/modelgrid3.jpeg",
              ),
            ),
          ),
        ),
      ),
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => DetaPage(
              img: "assets/images/modelgrid3.jpeg",
              logo: "assets/images/dress.jpg",
            ),
          ),
        );
      },
    );
  }

  InkWell modelIkiContainer() {
    return InkWell(
      child: Hero(
        tag: "assets/images/modelgrid2.jpeg",
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage(
                "assets/images/modelgrid2.jpeg",
              ),
            ),
          ),
        ),
      ),
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => DetaPage(
                  img: "assets/images/modelgrid2.jpeg",
                  logo: "assets/images/chanellogo.jpg",
                )));
      },
    );
  }

  InkWell modelBirContainer() {
    return InkWell(
      child: Hero(
        tag: "assets/images/modelgrid1.jpeg",
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            image: DecorationImage(
              fit: BoxFit.fill,
              image: AssetImage(
                "assets/images/modelgrid1.jpeg",
              ),
            ),
          ),
        ),
      ),
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => DetaPage(
                  img: "assets/images/modelgrid1.jpeg",
                  logo: "assets/images/chloelogo.png",
                )));
      },
    );
  }

  Container textContainer() {
    return Container(
      //color: Colors.green,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Text(
            "Abdlclksdiklcsdilkvnsldknvlksdnvlkskdnvlkdnkdnvlklssdnvsnkvsndvsdnkv<lhscbkjbcş<dncl<dsncil<ldsnclkdnclk<dscnlkş<snclksndclkns<ckns<ldkcn<sdncsn"),
      ),
    );
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
          ),
        ),
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
