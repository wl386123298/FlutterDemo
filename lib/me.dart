import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo/payment_info.dart';
import 'package:flutter_demo/tab/new.dart';
import 'package:flutter_demo/widget/common_widget.dart';
import 'package:fluttericon/elusive_icons.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:transition/transition.dart';

class MePage extends StatefulWidget {
  @override
  _FindPageState createState() => _FindPageState();
}

class _FindPageState extends State<MePage> {
  @override
  void initState() {
    print("me page");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Theme.of(context).scaffoldBackgroundColor,
        child: ListView(
          children: [
            Container(
              color: Colors.white,
              padding: EdgeInsets.symmetric(vertical: 40, horizontal: 15),
              child: Row(
                //crossAxisAlignment: CrossAxisAlignment.baseline,
                children: [
                  Container(
                      height: 70,
                      width: 70,
                      decoration: BoxDecoration(border: Border.all(color: Colors.black12, width: 0.1), borderRadius: BorderRadius.circular(5)),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(5),
                        child: Image.network(
                          "https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fpic2.zhimg.com%2F50%2Fv2-9eae8c8afdfac62b987a9f99280442a5_hd.jpg&refer=http%3A%2F%2Fpic2.zhimg.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=jpeg?sec=1617446148&t=ceac8e631bd5e8e23e27b84c1982aaab",
                          fit: BoxFit.cover,
                        ),
                      )),
                  Padding(padding: EdgeInsets.only(left: 12)),
                  Expanded(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "wliang",
                        style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.w600),
                      ),
                      Padding(padding: EdgeInsets.only(top: 5)),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Text(
                            "微信号：wvitas",
                            style: TextStyle(color: Colors.black54, fontSize: 14),
                          ),
                          Expanded(
                            child: Container(
                                alignment: Alignment.centerRight,
                                child: Icon(
                                  CupertinoIcons.qrcode,
                                  color: Colors.black45,
                                  size: 20,
                                )),
                          ),
                          Padding(padding: EdgeInsets.only(left: 10)),
                          Icon(CupertinoIcons.chevron_right, size: 16, color: Colors.black45)
                        ],
                      ),
                      InkWell(
                        onTap: () {},
                        child: Container(
                          margin: EdgeInsets.only(top: 3),
                          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                          decoration: BoxDecoration(border: Border.all(color: Colors.black12), borderRadius: BorderRadius.circular(50)),
                          child: Text(
                            "+状态",
                            style: TextStyle(color: Colors.black45, fontSize: 12),
                          ),
                        ),
                      )
                    ],
                  ))
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 10),
              padding: EdgeInsets.only(right: 15),
              color: Colors.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(child: Container(
                    alignment: Alignment.centerLeft,
                    child: FlatButton.icon(
                        onPressed: () {
                          Navigator.push(context, Transition(child: PaymentInfoPage(), transitionEffect: TransitionEffect.RIGHT_TO_LEFT));
                        },
                        icon: Image.asset(
                          "images/wechatpayline.png",
                          height: 25,
                        ),
                        label: Text("支付", style: TextStyle(color: Color(0xFF3333333)))),
                  )),
                  Icon(CupertinoIcons.chevron_right, size: 16, color: Colors.black45)
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
