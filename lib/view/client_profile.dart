import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:employee_mango/companent/app_bar_simple.dart';
import 'package:employee_mango/view/client/body_profile_client.dart';
import 'package:employee_mango/companent/colors.dart';
import 'package:employee_mango/companent/container_order.dart';
import 'package:employee_mango/companent/photo_profile.dart';
import 'package:employee_mango/prov/prov.dart';
import 'package:provider/provider.dart';

class ClientProfile extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ClientProfile();
  }
}

class _ClientProfile extends State<ClientProfile> {
  ColorsApp colorsApp = new ColorsApp();
  @override
  void initState() {
    // TODO: implement initState
    //changBodyProfileClient("data")
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<control>(context, listen: false)
          .changBodyProfileClient("data");
    });
    super.initState();
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
                // photo profile
                val.user_data == null
                    ? CircularProgressIndicator()
                    : val.user_data['message'] ==
                            "User data retrieved successfully."
                        ? Container(
                            child: Column(
                              children: [
                                PhotoProfile(
                                  image: val.image_client,
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 10),
                                  child: Text(
                                    "${val.user_data['data']['first_name']} ${val.user_data['data']['last_name']}",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Container(
                                  child:
                                      Text("${val.user_data['data']['email']}"),
                                ),
                                //body
                                Stack(
                                  alignment: val.body_client == "data"
                                      ? AlignmentDirectional.bottomStart
                                      : AlignmentDirectional.bottomEnd,
                                  children: [
                                    Container(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 20),
                                      height: 45,
                                      width: 250,
                                      margin:
                                          EdgeInsets.only(left: 20, top: 20),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(30),
                                          color: colorsApp.color_blak_app),
                                      child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            TextButton(
                                                onPressed: () {
                                                  val.changBodyProfileClient(
                                                      "data");
                                                  // val.GetUserData();
                                                },
                                                child: Text(
                                                  "بيانات العميل",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.white),
                                                )),
                                            Expanded(child: Container()),
                                            TextButton(
                                                onPressed: () {
                                                  val.changBodyProfileClient(
                                                      "orders");
                                                  val.GetUserOrders();
                                                },
                                                child: Text(
                                                  "الاوردرات",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.white),
                                                )),
                                          ]),
                                    ),
                                    Container(
                                      margin:
                                          EdgeInsets.only(left: 70, right: 40),
                                      height: 5,
                                      width: 40,
                                      color: colorsApp.color_yellow_body,
                                    )
                                  ],
                                ),
                                //data client
                                val.body_client == "data"
                                    ? BodyProfileClient()
                                    : val.user_orders == null
                                        ? Center(
                                            child: CircularProgressIndicator())
                                        : val.user_orders['message'] ==
                                                "User data retrieved successfully."
                                            ? Row(
                                                children: [
                                                  Expanded(
                                                      child:
                                                          ContainerOrderRealse(
                                                    color: const Color.fromARGB(
                                                        255, 147, 192, 230),
                                                    image_logo:
                                                        "assets/images/reals.png",
                                                    title: "فديو اعلاني",
                                                    data_order: val.user_orders,
                                                  )),
                                                  Expanded(
                                                      child:
                                                          ContainerOrderCampain(
                                                    color: const Color.fromARGB(
                                                        255, 147, 192, 230),
                                                    image_logo:
                                                        "assets/images/campainorder.png",
                                                    title: "حمله اعلانيه",
                                                    data_order: val.user_orders,
                                                  )),
                                                ],
                                              )
                                            : Center(
                                                child: IconButton(
                                                    onPressed: () {
                                                      val.GetUserOrders();
                                                    },
                                                    icon: Icon(Icons.refresh)),
                                              ),
                              ],
                            ),
                          )
                        : IconButton(
                            onPressed: () {
                              val.GetUserData();
                            },
                            icon: Icon(Icons.refresh)),
              ],
            ),
          ),
        ),
        floatingActionButton: Container(
          margin: EdgeInsets.only(right: 20, bottom: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              CircleAvatar(
                child: IconButton(
                  onPressed: () {
                    val.user_data == null
                        ? null
                        : Navigator.of(context).pushNamed("addreels");
                  },
                  icon: Icon(Icons.add_a_photo),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              CircleAvatar(
                child: IconButton(
                  onPressed: () {
                    val.user_data == null
                        ? null
                        : Navigator.of(context).pushNamed("addcampiagn");
                  },
                  icon: Icon(Icons.campaign),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
