
import 'package:flutter/material.dart';
import 'package:employee_mango/companent/colors.dart';
import 'package:employee_mango/prov/prov.dart';
import 'package:provider/provider.dart';

class BodyTasksEmployee extends StatelessWidget {
  BodyTasksEmployee({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    ColorsApp colorsApp = new ColorsApp();
    return Consumer<control>(builder: (context, val, child) {
      return val.datataskes == null
          ? CircularProgressIndicator()
          : val.datataskes['message'] == "Home Data."
              ? Container(
                  child: GridView.builder(
                    shrinkWrap: true,
                    physics: ClampingScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 4),
                    itemCount: val.datataskes['data'].length,
                    itemBuilder: (context, i) {
                      return MaterialButton(
                        onPressed: () {
                          //enter details task
                          val.task_id = val.datataskes['data'][i]['id'];
                          val.task_type = val.datataskes['data'][i]['type'];
                          val.user_id = val.datataskes['data'][i]['user_id'];

                          val.GetTaskesDetails(
                              "${val.datataskes['data'][i]['type']}",
                              val.datataskes['data'][i]['id']);

                          val.datataskes['data'][i]['type'] == "campaign"
                              ? Navigator.of(context)
                                  .pushNamed("campainordersdetails")
                              : val.datataskes['data'][i]['type'] == "reels"
                                  ? Navigator.of(context)
                                      .pushNamed("realsorderdetails")
                                  : null;
                          //بدل قيمه نلل للي في السطر اللي فوق احط عرض للاوفر
                        },
                        child: Container(
                          margin: EdgeInsets.all(10),
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: colorsApp.color_campain_container),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                alignment: Alignment.topRight,
                                child: Container(
                                  alignment: Alignment.center,
                                  width: 100,
                                  height: 35,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: Colors.white),
                                  child: Text(
                                    "${val.datataskes['data'][i]['type']}",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 20),
                                height: 40,
                                width: 40,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Colors.grey.shade400),
                                child: Icon(Icons.person_2_outlined),
                              ),
                              Container(
                                margin: EdgeInsets.symmetric(vertical: 10),
                                child: Text(
                                  val.datataskes['data'][i]['type'] == "reels"
                                      ? "${val.datataskes['data'][i]['first_name']} ${val.datataskes['data'][i]['last_name']}"
                                      : "${val.datataskes['data'][i]['user_first_name']} ${val.datataskes['data'][i]['user_last_name']}",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                              Text(val.datataskes['data'][i]['type'] ==
                                      "campaign"
                                  ? "حمله اعلانيه (${val.datataskes['data'][i]['order_type']})"
                                  : val.datataskes['data'][i]['type'] == "reels"
                                      ? "فديو ريلز"
                                      : "${val.datataskes['data'][i]['offer_title']}"),
                              Text(
                                textAlign: TextAlign.center,
                                val.datataskes['data'][i]['type'] == "campaign"
                                    ? "${val.datataskes['data'][i]['target']}... ${val.datataskes['data'][i]['target_area']}"
                                    : val.datataskes['data'][i]['type'] ==
                                            "reels"
                                        ? "${val.datataskes['data'][i]['product_name']}"
                                        : "",
                                style: TextStyle(color: Colors.grey),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                )
              : Center(
                  child:
                      IconButton(onPressed: () {}, icon: Icon(Icons.refresh)),
                );
    });
  }
}
