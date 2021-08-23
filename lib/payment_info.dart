import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo/widget/common_widget.dart';

class PaymentInfoPage extends StatefulWidget {
  @override
  _PaymentInfoPageState createState() => _PaymentInfoPageState();
}

class _PaymentInfoPageState extends State<PaymentInfoPage> {
  var _gridList = [
    {"icon": "images/icon_mobile_pay.png", "text": "手机充值"},
    {"icon": "images/icon_normal_pay.png", "text": "生活缴费"},
    {"icon": "images/icon_city_service.png", "text": "城市服务"},
    {"icon": "images/icon_welfare.png", "text": "腾讯公益"},
    {"icon": "images/icon_treatment_service.png", "text": "医疗健康"},
    {"icon": "images/icon_qr.png", "text": "防疫健康码"}
  ];

  @override
  void initState() {
    print(_gridList);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: commonAppBar(
          title: "支付",
          leading: Icon(
            CupertinoIcons.back,
            color: Colors.black54,
          )),
      body: Container(
        child: SingleChildScrollView(
            child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(vertical: 22),
              margin: EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Color(0xFF2CAD66),
              ),
              child: Row(
                children: [
                  Expanded(
                      child: Column(
                    children: [
                      Image.asset(
                        "images/icon_pay.png",
                        height: 30,
                        width: 30,
                      ),
                      Padding(padding: EdgeInsets.only(top: 10)),
                      Text(
                        "收付款",
                        style: TextStyle(color: Colors.white),
                      )
                    ],
                  )),
                  Expanded(
                      child: Column(
                    children: [
                      Image.asset(
                        "images/icon_wallet.png",
                        height: 30,
                        width: 30,
                      ),
                      Padding(padding: EdgeInsets.only(top: 10)),
                      Text(
                        "钱包",
                        style: TextStyle(color: Colors.white),
                      ),
                      Padding(padding: EdgeInsets.only(top: 5)),
                      Text(
                        "¥1,000,000",
                        style: TextStyle(color: Colors.white60, fontSize: 12),
                      )
                    ],
                  ))
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 10),
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 7),
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(5)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("生活服务", style: TextStyle(fontSize: 14, color: Colors.black45), textAlign: TextAlign.left),
                  Padding(padding: EdgeInsets.only(top: 30)),
                  GridView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      childAspectRatio: 1,
                      crossAxisCount: 4,
                      mainAxisSpacing: 7,
                    ),
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          Image.asset(_gridList[index]["icon"],height: 25,),
                          Padding(padding: EdgeInsets.only(top: 7)),
                          Text("${_gridList[index]["text"]}",style: TextStyle(color: Color(0xFF333333),fontSize: 13))],
                      );
                    },
                    itemCount: _gridList.length,
                  )
                ],
              ),
            )
          ],
        )),
      ),
    );
  }
}
