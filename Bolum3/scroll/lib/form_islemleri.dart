import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class FormIslemleri extends StatefulWidget {
  @override
  _FormIslemleriState createState() => _FormIslemleriState();
}

class _FormIslemleriState extends State<FormIslemleri> {
  String metin = "";
  int maxLine = 1;
  FocusNode _fNode;
  TextEditingController control1;

  @override
  void initState() {
    super.initState();
    control1 = TextEditingController(text: "Control");
    _fNode = FocusNode();
    _fNode.addListener(() {
      setState(() {
        if (_fNode.hasFocus) {
          maxLine = 3;
        } else
          maxLine = 1;
      });
    });
  }

  @override
  void dispose() {
    _fNode.dispose();
    control1.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: fabFocusNode(context),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: fabControl(),
          )
        ],
      ),
      appBar: appBar(),
      body: ListView(
        children: [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: textField(),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: textField2(),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: buildContainer(context),
          ),
        ],
      ),
    );
  }

  FloatingActionButton fabControl() {
    return FloatingActionButton(
      onPressed: () {
        print(control1.text.toString());
        control1.text = "ssds";
      },
      child: Icon(Icons.add),
      backgroundColor: Colors.teal,
    );
  }

  FloatingActionButton fabFocusNode(BuildContext context) {
    return FloatingActionButton(
      child: Icon(Icons.add),
      backgroundColor: Colors.orange,
      onPressed: () {
        FocusScope.of(context).requestFocus(_fNode);
      },
    );
  }

  Container buildContainer(BuildContext context) {
    return Container(
      color: Colors.teal.shade200,
      height: MediaQuery.of(context).size.height * (3 / 10),
      width: MediaQuery.of(context).size.width,
      child: Align(
        child: Text(metin),
        alignment: Alignment.center,
      ),
    );
  }

  TextField textField() {
    return TextField(
      keyboardType: TextInputType.number,
      textInputAction: TextInputAction.go,
      autofocus: false,
      maxLines: maxLine,
      focusNode: _fNode,
      maxLength: 20,
      maxLengthEnforcement: MaxLengthEnforcement.enforced,
      onChanged: (value) {
        debugPrint("on chenged value $value");
      },
      onSubmitted: (value) {
        print("On submit value $value");
        setState(() {
          metin = value;
        });
      },
      decoration: InputDecoration(
        hintText: "hint",
        labelText: "Label",
      ),
    );
  }

  TextField textField2() {
    return TextField(
      keyboardType: TextInputType.number,
      textInputAction: TextInputAction.go,
      autofocus: false,
      maxLines: 2,
      maxLength: 20,
      controller: control1,
      maxLengthEnforcement: MaxLengthEnforcement.enforced,
      onChanged: (value) {
        debugPrint("on chenged value $value");
      },
      onSubmitted: (value) {
        print("On submit value $value");
        setState(() {
          metin = value;
        });
      },
      decoration: InputDecoration(
        hintText: "hint",
        labelText: "Label",
      ),
    );
  }

  AppBar appBar() => AppBar(title: Text("Input Islemleri"));
}
