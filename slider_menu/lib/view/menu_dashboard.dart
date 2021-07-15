import 'package:flutter/material.dart';

class MenuDashboard extends StatefulWidget {
  final String title;
  MenuDashboard({required this.title});

  @override
  _MenuDashboardState createState() => _MenuDashboardState();
}

class _MenuDashboardState extends State<MenuDashboard>
    with SingleTickerProviderStateMixin {
  final TextStyle _textStyle = TextStyle(fontSize: 24, color: Colors.white);

  final Color backGroundColor = Color(0xFF343442);

  double? screenHeight = 100;
  double? screenWidth = 100;

  bool menuAktive = false;

  AnimationController? _controller;
  Animation<double>? _scaleAnimation;
  Animation<double>? _scaleMenuAnimation;
  Animation<Offset>? _menuOffsetAnimation;

  Duration _duration = Duration(milliseconds: 300);

  @override
  void initState() {
    super.initState();
    print(menuAktive.toString());
    _controller = AnimationController(vsync: this, duration: _duration);
    _scaleAnimation = Tween<double>(begin: 1, end: 0.6).animate(_controller!);
    _scaleMenuAnimation = Tween<double>(begin: 0, end: 1).animate(_controller!);
    _menuOffsetAnimation = Tween<Offset>(
            begin: Offset(-1, 0), end: Offset(0, 0))
        .animate(CurvedAnimation(parent: _controller!, curve: Curves.bounceIn));
  }

  @override
  void dispose() {
    _controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        backgroundColor: backGroundColor,
        body: Stack(
          children: [
            menuOlustur(context),
            dashBoardOlustur(context),
          ],
        ),
      ),
    );
  }

  menuOlustur(BuildContext context) {
    return SlideTransition(
      position: _menuOffsetAnimation!,
      child: ScaleTransition(
        scale: _scaleMenuAnimation!,
        child: Align(
          alignment: Alignment.centerLeft,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Dashboard", style: _textStyle),
              SizedBox(height: 5),
              Text("Mesajlar", style: _textStyle),
              SizedBox(height: 5),
              Text("Utility Bills", style: _textStyle),
              SizedBox(height: 5),
              Text("Fun transfer", style: _textStyle),
              SizedBox(height: 5),
              Text("Branches", style: _textStyle),
            ],
          ),
        ),
      ),
    );
  }

  dashBoardOlustur(BuildContext context) {
    return AnimatedPositioned(
      left: !menuAktive ? 0 : screenWidth! * 0.3,
      top: 0,
      bottom: 0,
      duration: _duration,
      child: ScaleTransition(
        scale: _scaleAnimation!,
        child: Material(
          elevation: 8,
          color: backGroundColor,
          borderRadius: menuAktive ? BorderRadius.circular(30) : null,
          child: Container(
            padding: EdgeInsets.only(left: 16, top: 8, right: 16),
            width: screenWidth, // menuAktive ? (0.6 * screenWidth!) :
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      InkWell(
                        onTap: () => _menuAktive(),
                        child: Icon(Icons.menu, color: Colors.white, size: 33),
                      ),
                      Text("My Cards", style: _textStyle),
                      Icon(Icons.add_sharp, color: Colors.white, size: 33),
                    ],
                  ),
                ),
                Container(
                  height: 200,
                  child: PageView(
                    children: [
                      Container(
                        color: Colors.orange,
                      ),
                      Container(
                        color: Colors.cyan,
                      )
                    ],
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemBuilder: (context, index) {
                      return Card(
                          child: ListTile(
                        leading: Icon(Icons.agriculture_outlined),
                      ));
                    },
                    itemCount: 20,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _menuAktive() {
    setState(() {
      menuAktive = !menuAktive;
      if (!menuAktive) {
        _controller!.reverse();
      } else {
        _controller!.forward();
      }
    });
  }
}
