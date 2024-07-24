import 'package:flutter/material.dart';
import 'package:employee_mango/companent/colors.dart';
import 'package:employee_mango/prov/prov.dart';
import 'package:jiffy/jiffy.dart';
import 'package:provider/provider.dart';

class DialogNotification {
  ColorsApp colorApp = new ColorsApp();
  Future<void> Notification(BuildContext context) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return Consumer<control>(builder: (context, val, child) {
          return AlertDialog(
            backgroundColor: Colors.white,
            shadowColor: Colors.white,
            scrollable: true,
            elevation: 10,
            content: Container(
                padding: EdgeInsets.only(top: 20),
                alignment: Alignment.center,
                child: Column(
                  children: [
                    Container(
                margin: EdgeInsets.symmetric(vertical: 20),
                padding: EdgeInsets.all(7),
                decoration: BoxDecoration(
                    color: colorApp.color_yellow_body,
                    borderRadius: BorderRadius.circular(30)),
                width: 200,
                height: 50,
                child: Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.white,
                      child: Image.asset("assets/images/mango.png"),
                    ),
                    Expanded(
                        child: Container(
                      alignment: Alignment.center,
                      child: Text("اشعاراتك",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    )),
                    CircleAvatar(
                        backgroundColor: Colors.white,
                        child: Icon(
                          Icons.notifications_outlined,
                          size: 18,
                        ))
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 10),
                
                child: Divider(
                  height: 1,
                  color: Colors.grey.shade200,
                  thickness: 2,
                  indent: MediaQuery.of(context).size.width / 4,
                  endIndent: MediaQuery.of(context).size.width / 4,
                ),
              ),
              //////
              val.notification == null
                  ? Center(
                      child: CircularProgressIndicator(
                      color: colorApp.color_yellow_body,
                    ))
                  : val.notification['message'] ==
                          "Notifications retrieved successfully."
                      ? ListView.builder(
                          shrinkWrap: true,
                          physics: ClampingScrollPhysics(),
                          itemCount: val.notification['data'].length,
                          itemBuilder: (context, i) {
                            return Container(
                              width: double.infinity,
                              child: Column(
                                children: [
                                  Directionality(
                                    textDirection: TextDirection.rtl,
                                    child: ListTile(
                                      leading: Stack(
                                        alignment: Alignment.topLeft,
                                        children: [
                                          CircleAvatar(
                                              backgroundColor: Colors.black,
                                              radius: 23,
                                              child: Image.asset(
                                                  "assets/images/mango.png")),
                                          val.notification['data'][i]['read'] ==
                                                  "false"
                                              ? CircleAvatar(
                                                  backgroundColor: Colors.green,
                                                  radius: 5,
                                                )
                                              : SizedBox()
                                        ],
                                      ),
                                      title: Text(
                                        "${val.notification['data'][i]['title']}",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14),
                                      ),
                                      subtitle: Text(
                                        "${Jiffy.parse(val.notification['data'][i]['created_at']).yMd} .. ${Jiffy.parse(val.notification['data'][i]['created_at']).jm}",
                                        style: TextStyle(
                                            color: Colors.grey, fontSize: 13),
                                      ),
                                    ),
                                  ),
                                  Container(
                                      margin: EdgeInsets.only(right: 30),
                                      alignment: Alignment.topRight,
                                      child: Text(
                                        textAlign: TextAlign.end,
                                        maxLines: 1,
                                        "${val.notification['data'][i]['description']}",
                                        style: TextStyle(fontSize: 13),
                                      )),
                                  Container(
                                    margin: EdgeInsets.symmetric(vertical: 10),
                                    child: Divider(
                                      height: 1,
                                      color: Colors.grey.shade200,
                                      thickness: 2,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          })
                      : IconButton(
                          onPressed: () {
                            val.GetAllNotification();
                          },
                          icon: Icon(Icons.refresh)),
                  ],
                ))
                ,
            actions: <Widget>[
               Consumer<control>(builder: (context, val, child) {
                      return MaterialButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Container(
                          alignment: Alignment.center,
                          height: 30,
                          width: 80,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: colorApp.color_yellow_body,
                          ),
                          child: Text( "رجوع",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      );
                    })
                  
            ],
          );
        });
      },
    );
  }
}
