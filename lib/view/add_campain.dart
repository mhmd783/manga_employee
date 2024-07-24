import 'package:employee_mango/companent/container_chose_platform.dart';
import 'package:employee_mango/companent/drop_dowen_goal.dart';
import 'package:employee_mango/companent/text_field_vote.dart';
import 'package:employee_mango/view/client/dialog_campain.dart';
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

class AddCampiagn extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _AddCampiagn();
  }
}

class _AddCampiagn extends State<AddCampiagn> {
  ColorsApp colorsApp = new ColorsApp();
  GlobalKey<FormState> formstate = GlobalKey();
  DialogCampaign dialogCampaign = new DialogCampaign();
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
                  child: Column(children: [
                //app bar
                AppBarAppSimple(),
                // photo profile
                val.user_data == null
                    ? CircularProgressIndicator()
                    : val.user_data['message'] ==
                            "User data retrieved successfully."
                        ? Container(
                            child: Column(children: [
                            PhotoProfile(
                              image: val.image_client,
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 10),
                              child: Text(
                                "${val.user_data['data']['first_name']} ${val.user_data['data']['last_name']}",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                            Container(
                              child: Text("${val.user_data['data']['email']}"),
                            ),
                          ]))
                        : SizedBox(),
                Container(
                  width: 600,
                  margin: EdgeInsets.only(top: 10, right: 20, bottom: 5),
                  alignment: Alignment.centerRight,
                  child: Text(
                    "حدد نوع منصه اعلانك",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                //////together
                Container(
                  width: 500,
                  child: Row(
                    children: [
                      Expanded(
                        child: MaterialButton(
                          padding: EdgeInsets.all(5),
                          onPressed: () {
                            val.ChoseTypeCampain("facebook&instgram");
                          },
                          child: Container(
                            height: 120,
                            width: 150,
                            decoration: BoxDecoration(
                              border: val.api.order_type_campain ==
                                      "facebook&instgram"
                                  ? Border.all(
                                      color: Colors.black,
                                      width: 1,
                                      style: BorderStyle.solid,
                                      strokeAlign: BorderSide.strokeAlignCenter)
                                  : null,
                              borderRadius: BorderRadius.circular(20),
                              color: colorsApp.colorinasta_face,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Stack(
                                  alignment: AlignmentDirectional.center,
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(
                                          bottom: 10, right: 30),
                                      height: 40,
                                      width: 40,
                                      child: Image.asset(
                                          "assets/images/instgram.png"),
                                    ),
                                    Container(
                                      margin:
                                          EdgeInsets.only(bottom: 10, left: 30),
                                      height: 40,
                                      width: 40,
                                      child: Image.asset(
                                          "assets/images/facebook.png"),
                                    ),
                                  ],
                                ),
                                Text("كلاهما")
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: MaterialButton(
                          padding: EdgeInsets.all(5),
                          onPressed: () {
                            val.ChoseTypeCampain("instgram");
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              border: val.api.order_type_campain == "instgram"
                                  ? Border.all(
                                      color: Colors.black,
                                      width: 1,
                                      style: BorderStyle.solid,
                                      strokeAlign: BorderSide.strokeAlignCenter)
                                  : null,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: PlatForm(
                                text: "انستجرام",
                                image: "assets/images/instgram.png",
                                color: colorsApp.colorinstgram),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: MaterialButton(
                          padding: EdgeInsets.all(5),
                          onPressed: () {
                            val.ChoseTypeCampain("facebook");
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              border: val.api.order_type_campain == "facebook"
                                  ? Border.all(
                                      color: Colors.black,
                                      width: 1,
                                      style: BorderStyle.solid,
                                      strokeAlign: BorderSide.strokeAlignCenter)
                                  : null,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: PlatForm(
                                text: "فيسبوك",
                                image: "assets/images/facebook.png",
                                color: colorsApp.colorfacebook),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                ///
                val.api.order_type_campain != ""
                    ? Form(
                        key: formstate,
                        child: Container(
                          width: 600,
                          child: Column(
                            children: [
                              val.api.order_type_campain == "instgram"
                                  ? Container()
                                  : Container(
                                      margin: EdgeInsets.only(top: 20),
                                      child: TextFormFiledVoteNotValied(
                                          hintText:
                                              "أدخل رابط صفحتك الاعلانية علي فايسبوك",
                                          controll:
                                              val.api.link_facebook_campain,
                                          sufixicon: Container(
                                              padding: EdgeInsets.all(10),
                                              height: 20,
                                              width: 20,
                                              child: Image.asset(
                                                  "assets/images/facebook.png")),
                                          keyboard: TextInputType.text),
                                    ),
                              val.api.order_type_campain == "facebook"
                                  ? Container()
                                  : Container(
                                      margin: EdgeInsets.only(top: 0),
                                      child: TextFormFiledVoteNotValied(
                                          hintText:
                                              "أدخل رابط صفحتك الاعلانية علي انستجرام",
                                          controll:
                                              val.api.link_instgram_campain,
                                          sufixicon: Container(
                                              padding: EdgeInsets.all(10),
                                              height: 20,
                                              width: 20,
                                              child: Image.asset(
                                                  "assets/images/instgram.png")),
                                          keyboard: TextInputType.text),
                                    ),
                              val.api.order_type_campain == "instgram"
                                  ? Container()
                                  : Container(
                                      margin: EdgeInsets.symmetric(vertical: 0),
                                      child: TextFormFiledVote(
                                          hintText:
                                              "ادخل رايط المنشور علي فيسبوك",
                                          controll: val
                                              .api.link_post_campain_facebook,
                                          sufixicon: Icon(Icons.link),
                                          keyboard: TextInputType.text),
                                    ),
                              val.api.order_type_campain == "facebook"
                                  ? Container()
                                  : Container(
                                      margin: EdgeInsets.symmetric(vertical: 0),
                                      child: TextFormFiledVote(
                                          hintText: "رابط المنشور علي انستجرام",
                                          controll: val
                                              .api.link_post_campain_instgram,
                                          sufixicon: Icon(Icons.link),
                                          keyboard: TextInputType.text),
                                    ),
                              DrobDowenGoal(
                                  selectedValue: val.selectedGoal,
                                  dropdownItems: val.dropdownItemsGoal),
                              Container(
                                margin: EdgeInsets.only(top: 20, right: 5),
                                alignment: Alignment.centerRight,
                                child: Text(
                                  "حدد الميزانيه اليوميه (اختياري)",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                              Container(
                                child: TextFormFiledVoteNotValied(
                                    hintText: "من 10\$ الي 900\$ يوميا",
                                    controll: val.api.salaryforday_campain,
                                    sufixicon: Icon(Icons.money),
                                    keyboard: TextInputType.number),
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 10, right: 5),
                                alignment: Alignment.centerRight,
                                child: Text(
                                  "حدد منطقه الجمهور المستهدف",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                              Container(
                                child: TextFormFiledVote(
                                    hintText: "القدس ,الداخل 48 الضفه الغربه",
                                    controll: val.api.target_area_campain,
                                    sufixicon: Icon(Icons.location_city),
                                    keyboard: TextInputType.text),
                              ),
                              MaterialButton(
                                onPressed: () {
                                  if (formstate.currentState!.validate()) {
                                    val.Camapain();
                                    dialogCampaign.Campain(context);
                                    print("validat");
                                  } else {
                                    print("not validat");
                                  }
                                  print(val.api.tokenbox.get("token"));
                                },
                                child: Container(
                                  margin: EdgeInsets.symmetric(vertical: 20),
                                  alignment: Alignment.center,
                                  width: 100,
                                  height: 45,
                                  decoration: BoxDecoration(
                                      color: colorsApp.color_yellow_body,
                                      borderRadius: BorderRadius.circular(30)),
                                  child: Text(
                                    "ارسال",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    : Container(),
              ]))));
    });
  }
}
