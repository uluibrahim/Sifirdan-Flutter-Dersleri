import 'package:flutter/material.dart';

class CustomScrollViewKullanimi extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          leading: Icon(Icons.real_estate_agent_rounded),
          backgroundColor: Colors.red,
          title: Text("Title"),
          expandedHeight: 200,
          floating: true,
        ),
      ],
    );
  }
}
