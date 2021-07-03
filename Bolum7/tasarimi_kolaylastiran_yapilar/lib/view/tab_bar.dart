import 'package:flutter/material.dart';

class TabBarKullanimi extends StatefulWidget {
  TabBarKullanimi({Key? key}) : super(key: key);

  @override
  _TabBarKullanimiState createState() => _TabBarKullanimiState();
}

class _TabBarKullanimiState extends State<TabBarKullanimi>
    with SingleTickerProviderStateMixin {
  TabController? tabController;
  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TabBarView(
        children: [
          Container(
            color: Colors.red,
          ),
          Container(color: Colors.green),
        ],
        controller: tabController,
      ),
      appBar: AppBar(
        title: Text("Tab Bar"),
        bottom: tabBar(),
      ),
    );
  }

  TabBar tabBar() {
    return TabBar(
      isScrollable: false,
      automaticIndicatorColorAdjustment: true,
      indicator: BoxDecoration(
        color: Colors.tealAccent,
      ),
      indicatorPadding: EdgeInsets.all(5),
      controller: tabController,
      tabs: [
        Tab(
          icon: Icon(Icons.pageview),
          text: "sdcdsc",
        ),
        Tab(
          icon: Icon(Icons.pageview),
          text: "sdcdccsc",
        ),
      ],
    );
  }
}
