import 'package:employee_mango/companent/dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:employee_mango/companent/app_bar_simple.dart';
import 'package:employee_mango/companent/container_reals_order_details.dart';
import 'package:employee_mango/prov/prov.dart';
import 'package:employee_mango/view/orders_details/body_details_order.dart';
import 'package:employee_mango/view/client/body_profile_client.dart';
import 'package:employee_mango/companent/colors.dart';
import 'package:employee_mango/companent/container_order.dart';
import 'package:employee_mango/companent/photo_profile.dart';
import 'package:provider/provider.dart';

class RealsOrdersDetails extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _RealsOrdersDetails();
  }
}

class _RealsOrdersDetails extends State<RealsOrdersDetails> {
  ColorsApp colorsApp = new ColorsApp();
  DialogApp dialogApp = new DialogApp();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<control>(builder: (context, val, child) {
      return Scaffold(
        body: MediaQuery.of(context).size.width < 1000 ||
                MediaQuery.of(context).size.height < 600
            ? Container(
                child: Center(
                  child: Text("كبر حجم الشاشه"),
                ),
              )
            : Container(
          padding: EdgeInsets.all(10),
          child: SingleChildScrollView(
            child: Column(
              children: [
                //app bar
                AppBarAppSimple(),
                //photo profile
                // val.details_order_reals == null
                //     ? Center(child: CircularProgressIndicator())
                //     : val.details_order_reals['message'] ==
                //             "User and reels data retrieved successfully."
                //         ?

                val.datataskesdetails == null
                    ? Center(child: CircularProgressIndicator())
                    : val.datataskesdetails['message'] == "Reels Data"
                        ? Container(
                            width: double.infinity,
                            child: Column(
                              children: [
                                PhotoProfile(image: val.image_client_reals
                                    //"${val.details_order_reals['data']['image']}",
                                    ),
                                Container(
                                  margin: EdgeInsets.only(top: 10),
                                  child: TextButton(
                                    onPressed: () {
                                      val.id_user = val
                                          .datataskesdetails['data']['user_id'];
                                      val.GetUserData();
                                      Navigator.of(context)
                                          .pushNamed("profileclient");
                                    },
                                    child: Text(
                                      "${val.datataskesdetails['data']['user']['first_name']} ${val.datataskesdetails['data']['user']['last_name']}",
                                      //"${val.details_order_reals['data']['first_name']} ${val.details_order_reals['data']['last_name']}",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),

                                Container(
                                  child: Text(
                                      "${val.datataskesdetails['data']['user']['email']}"
                                      //"${val.details_order_reals['data']['email']}"
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
                                      "مقطع ريلز",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Container(
                                        margin: EdgeInsets.only(left: 10),
                                        height: 25,
                                        width: 25,
                                        child: Image.asset(
                                            "assets/images/reals.png")),
                                  ],
                                ),
                                //body
                                Container(
                                  padding: EdgeInsets.all(40),
                                  child: Row(children: [
                                    //image
                                    Expanded(
                                      child: Container(
                                          height: 500,
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(50),
                                                bottomRight:
                                                    Radius.circular(50)),
                                            child: val.image_reals != null
                                                ? Image.file(
                                                    val.image_reals!,
                                                    fit: BoxFit.cover,
                                                  )
                                                : Icon(
                                                    Icons.photo_outlined,
                                                    size: 50,
                                                  ),
                                          )),
                                    ),

                                    Expanded(
                                        flex: 2,
                                        child: Container(
                                          child: Column(
                                            children: [
                                              Row(
                                                children: [
                                                  Expanded(
                                                    child: ContainerRealsOrdersDetails(
                                                        title: "وصف المنتج",
                                                        subtitle:
                                                            "${val.datataskesdetails['data']['product_description']}"
                                                        //"${val.details_order_reals['data']['product_description']}"
                                                        ),
                                                  ),
                                                  Expanded(
                                                    child: ContainerRealsOrdersDetails(
                                                        title: "اسم المنتج",
                                                        subtitle:
                                                            '${val.datataskesdetails['data']['product_name']}'
                                                        // "${val.details_order_reals['data']['product_name']}"

                                                        ),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                height: 30,
                                              ),
                                              Row(
                                                children: [
                                                  Expanded(
                                                    child: ContainerRealsOrdersDetails(
                                                        title: "سعر المنتج",
                                                        subtitle:
                                                            "${val.datataskesdetails['data']['product_price']}"
                                                        //"${val.details_order_reals['data']['product_price']}"
                                                        ),
                                                  ),
                                                  Expanded(
                                                    child: ContainerRealsOrdersDetails(
                                                        title:
                                                            "طريقه استخدام المنتج",
                                                        subtitle:
                                                            "${val.datataskesdetails['data']['product_usage']}"
                                                        //"${val.details_order_reals['data']['product_usage']}"
                                                        ),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                height: 30,
                                              ),
                                              Row(
                                                children: [
                                                  Expanded(
                                                    child: ContainerRealsOrdersDetails(
                                                        title:
                                                            "الهدايا علي المنتج",
                                                        subtitle:
                                                            "${val.datataskesdetails['data']['gift']}"
                                                        //"${val.details_order_reals['data']['gift']}"
                                                        ),
                                                  ),
                                                  SizedBox(
                                                    width: 20,
                                                  ),
                                                  Expanded(
                                                    child: ContainerRealsOrdersDetails(
                                                        title:
                                                            "العروض علي المنتج",
                                                        subtitle:
                                                            "${val.datataskesdetails['data']['offers']}"
                                                        //"${val.details_order_reals['data']['offers']}"
                                                        ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ))
                                  ]),
                                )
                              ],
                            ),
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
            : val.datataskesdetails['message'] == "Reels Data"
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
