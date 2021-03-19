import 'package:flutter/material.dart';
import 'package:flutter_demo/widget/common_widget.dart';

class HotPage extends StatefulWidget {
  @override
  _HotPageState createState() => _HotPageState();
}

class _HotPageState extends State<HotPage> {
  @override
  void initState() {
    print("hot page");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Text("hot"),
      ),
    );
  }
}
