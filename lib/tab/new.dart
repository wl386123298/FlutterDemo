import 'package:flutter/material.dart';

class NewPage extends StatefulWidget {

  NewPage({Key key}):super(key: key);

  @override
  _NewPageState createState() => _NewPageState();
}

class _NewPageState extends State<NewPage> {

  @override
  void initState() {
    print("new page");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(child: ListView.builder(
          itemCount: 50,
          itemBuilder: (context, index){
        return Text("$index");
      })),
    );
  }
}
