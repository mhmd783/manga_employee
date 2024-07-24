import 'package:employee_mango/companent/colors.dart';
import 'package:employee_mango/prov/prov.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DialogReels {
  ColorsApp colorsApp = new ColorsApp();
  Future<void> Reals(BuildContext context) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return Consumer<control>(builder: (context, val, child) {
          // val.vote['message'] == "Poll Created Successfully"?
          return AlertDialog(
            backgroundColor: Colors.white,
            shadowColor: Colors.white,

            scrollable: true,
            // titleTextStyle: TextStyle(fontSize: 20, color: Colors.black),
            // title: Text('Verify'),
            elevation: 10,
            content: Container(
                padding: EdgeInsets.only(top: 20),
                alignment: Alignment.center,
                child: Column(
                  children: [
                    Container(
                      height: 40,
                      width: 40,
                      child: Image.asset("assets/images/mango.png"),
                    ),
                    Container(
                      height: 50,
                      width: 150,
                      child: Image.asset( "assets/images/mangomedia.png",
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 10),
                      child: Divider(
                        height: 1,
                        color: Colors.grey.shade300,
                        thickness: 2,
                        endIndent: 50,
                        indent: 50,
                      ),
                    ),
                    Container(
                        margin: EdgeInsets.only(top: 20),
                        alignment: Alignment.center,
                        child: val.reals == null
                            ? CircularProgressIndicator(
                                color: colorsApp.color_yellow_body,
                              )
                            : val.reals['message'] ==
                                    "The Reels has been requested successfully. We will contact you"
                                ? Text( "تم الارسال",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: colorsApp.color_grean_body))
                                : val.reals['message'] ==
                                        "User has no Subscription"
                                    ? Text( "لا يوجد اشتراك",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.red))
                                    : Text("خطاء",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.red))),
                  ],
                )),
            actions: <Widget>[
              val.reals == null
                  ? Consumer<control>(builder: (context, val, child) {
                      return MaterialButton(
                        onPressed: () {},
                        child: Container(
                          alignment: Alignment.center,
                          height: 30,
                          width: 80,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: colorsApp.color_yellow_body,
                          ),
                          child: Text( "رجوع",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      );
                    })
                  : val.reals['message'] ==
                          "The Reels has been requested successfully. We will contact you"
                      ? Consumer<control>(builder: (context, val, child) {
                          return Container(
                            alignment: Alignment.center,
                            padding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 5),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: colorsApp.color_yellow_body,
                            ),
                            child: MaterialButton(
                              child: Text("تم",
                                style: TextStyle(color: Colors.white),
                              ),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                          );
                        })
                      : Consumer<control>(builder: (context, val, child) {
                          return Container(
                            alignment: Alignment.center,
                            height: 30,
                            width: 80,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: colorsApp.color_yellow_body,
                            ),
                            child: MaterialButton(
                              child: Text("رجوع",
                                style: TextStyle(color: Colors.white),
                              ),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                          );
                        }),
            ],
          );
        });
      },
    );
  }
}
