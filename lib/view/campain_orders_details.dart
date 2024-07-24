import 'package:employee_mango/companent/dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:employee_mango/companent/app_bar_simple.dart';
import 'package:employee_mango/prov/prov.dart';
import 'package:employee_mango/view/orders_details/body_details_order.dart';
import 'package:employee_mango/view/client/body_profile_client.dart';
import 'package:employee_mango/companent/colors.dart';
import 'package:employee_mango/companent/container_order.dart';
import 'package:employee_mango/companent/photo_profile.dart';
import 'package:provider/provider.dart';

class CampainOrdersDetails extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _CampainOrdersDetails();
  }
}

class _CampainOrdersDetails extends State<CampainOrdersDetails> {
  ColorsApp colorsApp = new ColorsApp();
  DialogApp dialogApp = new DialogApp();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
    //   Provider.of<control>(context, listen: false).GetDetailsOrderCampain();
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<control>(builder: (context, val, child) {
      return Scaffold(
        body:MediaQuery.of(context).size.width < 1000 ||
                MediaQuery.of(context).size.height < 600
            ? Container(
                child: Center(
                  child: Text("كبر حجم الشاشه"),
                ),
              )
            :  Container(
          padding: EdgeInsets.all(10),
          child: SingleChildScrollView(
            child: Column(
              children: [
                //app bar
                AppBarAppSimple(),
                //photo profile
                val.datataskesdetails == null
                    ? CircularProgressIndicator()
                    : val.datataskesdetails['message'] == "Campaign Data"
                        ? Container(
                            child: Column(
                            children: [
                              PhotoProfile(
                                image: val.image_client_campain,
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 10),
                                child: TextButton(
                                  onPressed: () {
                                    val.id_user = val.datataskesdetails['data']
                                        ['user_id'];
                                    val.GetUserData();
                                    Navigator.of(context)
                                        .pushNamed("profileclient");
                                  },
                                  child: Text(
                                    "${val.datataskesdetails['data']['user']['first_name']} ${val.datataskesdetails['data']['user']['last_name']}",
                                    //"${val.details_order_campain['data']['first_name']} ${val.details_order_campain['data']['last_name']}",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),

                              Container(
                                child: Text(
                                    "${val.datataskesdetails['data']['user']['email']}"
                                    //"${val.details_order_campain['data']['email']}"
                                    ),
                              ),
                              Container(
                                margin: EdgeInsets.all(10),
                                width: 150,
                                child: Divider(
                                  height: 1,
                                  color: Colors.grey.shade300,
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "حمله اعلانيه علي(${val.datataskesdetails['data']['order_type']})",
                                    //"حمله علي ${val.details_order_campain['data']['order_type']}",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(left: 10),
                                    height: 25,
                                    width: 50,
                                    child: val.datataskesdetails['data']
                                                ['order_type'] ==
                                            "facebook"
                                        ? Image.asset(
                                            "assets/images/facebook.png")
                                        : val.datataskesdetails['data']
                                                    ['order_type'] ==
                                                "instgram"
                                            ? Image.asset(
                                                "assets/images/instgram.png")
                                            : Stack(
                                                children: [
                                                  Container(
                                                    margin: EdgeInsets.only(
                                                        left: 20),
                                                    child: Image.asset(
                                                        "assets/images/instgram.png"),
                                                  ),
                                                  Image.asset(
                                                      "assets/images/facebook.png"),
                                                ],
                                              ),
                                  ),
                                ],
                              ),
                              //body
                              BodyDetailsOrder(
                                  details_order_campain: val.datataskesdetails
                                  //val.details_order_campain,
                                  )
                            ],
                          )
                            // : Center(
                            //     child: IconButton(
                            //         onPressed: () {
                            //           val.GetDetailsOrderReals();
                            //         },
                            //         icon: Icon(Icons.refresh)),
                            //   ),
                            )
                        : Center(
                            child: Text(
                              "لم يجلب بيانات",
                              style: TextStyle(color: Colors.grey),
                            ),
                          ),
              ],
            ),
          ),
        ),
        floatingActionButton: val.datataskesdetails == null
            ? null
            : val.datataskesdetails['message'] == "Campaign Data"
                ? val.datataskesdetails['data']['status_finished'] != null
                    ? null
                    : FloatingActionButton(
                        backgroundColor: colorsApp.color_red_body,
                        onPressed: () {
                          dialogApp.CompletTask(context);
                        },
                        child: Icon(Icons.done),
                      )
                : null,
      );
    });
  }
}
