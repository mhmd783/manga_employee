import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:employee_mango/companent/app_bar_simple.dart';
import 'package:employee_mango/view/employee/body_data_employee.dart';
import 'package:employee_mango/view/employee/body_taskes_employee.dart';
import 'package:employee_mango/companent/colors.dart';
import 'package:employee_mango/companent/photo_profile.dart';
import 'package:employee_mango/prov/prov.dart';
import 'package:employee_mango/view/employee/dialog_employee.dart';

class Employee extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _Employee();
  }
}

class _Employee extends State<Employee> {
  DialogEmployee dialogEmployee = new DialogEmployee();
  ColorsApp colorsApp = new ColorsApp();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<control>(context, listen: false).ProsessIamgeProfile();
    });
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<control>(context, listen: false).GetTaskesNotDone();
    });
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<control>(context, listen: false).GetCountAllNotification();
    });
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
                AppBarEmployee(),
                //photo profile
                PhotoProfile(
                  image: val.image_profile,
                ),
                Container(
                  margin: EdgeInsets.only(top: 10),
                  child: Text(
                    "${val.api.namebox.get("name")}", //"${val.one_employee['name']}",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  child: Text(
                      "${val.api.emailbox.get("email")}" //"${val.one_employee['email']}"
                      ),
                ),
                //body
                Stack(
                  alignment: AlignmentDirectional.bottomEnd,
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      height: 45,
                      width: 420,
                      margin: EdgeInsets.only(left: 20, top: 20),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: colorsApp.color_blak_app),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              flex: 3,
                              child: TextButton(
                                  onPressed: () {
                                    val.changeBodyEmployee("data");
                                    val.GetCountAllNotification();
                                  },
                                  child: Text(
                                    "بيانات الموظف",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  )),
                            ),
                            Expanded(
                              flex: 3,
                              child: TextButton(
                                  onPressed: () {
                                    val.GetTaskesDone();
                                    val.changeBodyEmployee("alltaskes");
                                    val.GetCountAllNotification();
                                  },
                                  child: Text(
                                    "كل المهام",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  )),
                            ),
                            Expanded(
                              flex: 3,
                              child: TextButton(
                                  onPressed: () {
                                    val.GetTaskesNotDone();
                                    val.changeBodyEmployee("todaytaskes");
                                    val.GetCountAllNotification();
                                  },
                                  child: Text(
                                    val.datataskes == null
                                        ? "المهام اليوميه"
                                        : val.datataskes['message'] ==
                                                "Home Data."
                                            ? "المهام اليوميه ${val.datataskes['data'].length}"
                                            : "المهام اليوميه",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  )),
                            ),
                          ]),
                    ),
                    Container(
                      //310/190/60
                      margin: EdgeInsets.only(
                          right: val.body_employee == "data"
                              ? 310
                              : val.body_employee == "alltaskes"
                                  ? 190
                                  : 60),
                      height: 5,
                      width: 40,
                      color: colorsApp.color_yellow_body,
                    )
                  ],
                ),
                //data employee
                val.body_employee == "data"
                    ? Center(child: BodyDataEmployee())
                    : Center(child: BodyTasksEmployee()),
              ],
            ),
          ),
        ),
      );
    });
  }
}
