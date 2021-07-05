import 'package:flutter/material.dart';

class DetaPage extends StatefulWidget {
  String img;
  String logo;
  DetaPage({required this.img, required this.logo});

  @override
  _DetaPageState createState() => _DetaPageState(img, logo);
}

class _DetaPageState extends State<DetaPage> {
  String img;
  String logo;
  double? contHeigth;
  _DetaPageState(this.img, this.logo);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          heroAnimasyon(context),
          Padding(
            padding: const EdgeInsets.only(bottom: 20.0),
            child: Material(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              child: Container(
                decoration: BoxDecoration(),
                height: contHeigth = MediaQuery.of(context).size.height * 0.40,
                width: MediaQuery.of(context).size.width * 0.85,
                child: Column(
                  children: [
                    Expanded(
                      flex: 75,
                      child: Row(
                        children: [
                          Expanded(
                            flex: 42,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                height: contHeigth! * 0.75,
                                decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20)),
                                  image: DecorationImage(
                                    fit: BoxFit.fill,
                                    image: AssetImage(img),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 58,
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Expanded(
                                    flex: 20,
                                    child: Text(
                                      "LAMINATED ",
                                      style: TextStyle(
                                        fontFamily: "Montserrat",
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 30,
                                    child: Row(
                                      children: [
                                        Text(
                                          "Louis vuitton",
                                          style: TextStyle(
                                            fontFamily: "Montserrat",
                                            fontSize: 16,
                                          ),
                                        ),
                                        SizedBox(width: 10),
                                        Container(
                                          height: 20,
                                          width: 20,
                                          child: Image.asset(logo,
                                              fit: BoxFit.fill),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    flex: 40,
                                    child: Text(
                                      "One button V-neck sling longsleved waist female stitching dress ",
                                      style: TextStyle(
                                        fontFamily: "Montserrat",
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(flex: 3, child: divider()),
                    Expanded(flex: 22, child: priceAndButtonRow()),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Divider divider() => Divider(thickness: 1.5);

  Row priceAndButtonRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Text("\$6500"),
        IconButton(
          onPressed: () {},
          icon: Icon(Icons.arrow_right),
        ),
      ],
    );
  }

  Hero heroAnimasyon(BuildContext context) {
    return Hero(
      tag: widget.img,
      child: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(img),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
