import 'package:employee_mango/companent/container_chose_platform.dart';
import 'package:employee_mango/companent/text_field_vote.dart';
import 'package:employee_mango/view/client/doalog_reels.dart';
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

class AddReels extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _AddReels();
  }
}

class _AddReels extends State<AddReels> {
  ColorsApp colorsApp = new ColorsApp();
  GlobalKey<FormState> formstate = GlobalKey();
  DialogReels dialogReels = new DialogReels();
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

                ///
                //////together
                Container(
                  margin: EdgeInsets.only(top: 20),
                  width: 500,
                  child: Form(
                    key: formstate,
                    child: Column(
                      children: [
                        PlatForm(
                            text: "فيديو اعلاني",
                            image: "assets/images/reals.png",
                            color: colorsApp.colorreals),
                    
                        ////Form
                        Container(
                          margin: EdgeInsets.only(top: 20, right: 5, bottom: 0),
                          alignment: Alignment.centerRight,
                          child: Text(
                            "اكتب اسم المنتج ",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 5),
                          child: TextFormFiledVote(
                              hintText: "اكتب اسم المنتج",
                              controll: val.api.name_prodect,
                              sufixicon: Container(
                                width: 1,
                              ),
                              keyboard: TextInputType.text),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 20, right: 5, bottom: 10),
                          alignment: Alignment.centerRight,
                          child: Text(
                            "قم بتحميل صوره للمنتج",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        MaterialButton(
                          onPressed: () {
                            val.getphoto();
                          },
                          child: Container(
                            height: 150,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              border: Border.all(
                                  color: Colors.black,
                                  width: 1,
                                  style: BorderStyle.solid,
                                  strokeAlign: BorderSide.strokeAlignCenter),
                              borderRadius: BorderRadius.circular(20),
                              color: const Color.fromARGB(255, 250, 250, 250),
                            ),
                            child: val.image == null
                                ? Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        margin: EdgeInsets.only(bottom: 10),
                                        height: 40,
                                        width: 40,
                                        child: Icon(Icons.add_a_photo),
                                      ),
                                      Text('اضافه صوره')
                                    ],
                                  )
                                : Image.file(val.image!),
                          ),
                        ),
                        //
                        Container(
                          margin: EdgeInsets.only(top: 20, right: 5, bottom: 0),
                          alignment: Alignment.centerRight,
                          child: Text(
                            "اكتب وصف عن منتجك",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        TextFormField(
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "فارغ";
                            }
                            return null;
                          },
                          textAlign: TextAlign.end,
                          minLines: 3,
                          maxLines: 3,
                          keyboardType: TextInputType.text,
                          controller: val.api.description_prodect,
                          decoration: InputDecoration(
                            hintStyle: TextStyle(
                                color: Colors.grey.shade400,
                                fontSize: 15,
                                fontWeight: FontWeight.w300),
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 10),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15)),
                            hintText: "اكتب وصف كامل للمنتج",
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 20, right: 5, bottom: 10),
                          alignment: Alignment.centerRight,
                          child: Text(
                            "اكتب طريقه استخدام المنتج",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        TextFormField(
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "فارغ";
                            }
                            return null;
                          },
                          textAlign: TextAlign.end,
                          minLines: 3,
                          maxLines: 3,
                          keyboardType: TextInputType.text,
                          controller: val.api.roude_usage_prodect,
                          decoration: InputDecoration(
                            hintStyle: TextStyle(
                                color: Colors.grey.shade400,
                                fontSize: 15,
                                fontWeight: FontWeight.w300),
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 10),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15)),
                            hintText: "اكتب طريقه استخدام المنتج",
                          ),
                        ),
                        //
                        ////Form
                        Container(
                          margin: EdgeInsets.only(top: 20, right: 5, bottom: 0),
                          alignment: Alignment.centerRight,
                          child: Text(
                            "ادخل سعر منتجك",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 5),
                          child: TextFormFiledVote(
                              hintText: "السعر",
                              controll: val.api.salary_prodect,
                              sufixicon: Container(
                                width: 1,
                              ),
                              keyboard: TextInputType.number),
                        ),
                    
                        Container(
                          margin: EdgeInsets.only(top: 20, right: 5, bottom: 10),
                          alignment: Alignment.centerRight,
                          child: Text(
                            "هل لديك عروض للمنتج",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 5),
                          child: TextFormFiledVote(
                              hintText: "اكتب عرض",
                              controll: val.api.offers_prodect,
                              sufixicon: Container(
                                width: 1,
                              ),
                              keyboard: TextInputType.text),
                        ),
                    
                        Container(
                          margin: EdgeInsets.only(top: 20, right: 5, bottom: 10),
                          alignment: Alignment.centerRight,
                          child: Text(
                            "هل المنتج يعلن معه عن هدايا",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 5),
                          child: TextFormFiledVote(
                              hintText: "اكتب الهدايا",
                              controll: val.api.gift_prodect,
                              sufixicon: Container(
                                width: 1,
                              ),
                              keyboard: TextInputType.text),
                        ),
                    
                        Container(
                          margin: EdgeInsets.only(right: 5, top: 20, bottom: 10),
                          child: MaterialButton(
                            onPressed: () {
                              if (formstate.currentState!.validate()) {
                                val.Reals();
                                dialogReels.Reals(context);
                                print("validat");
                              } else {
                                print("not validat");
                              }
                            },
                            child: Container(
                                width: 100,
                                height: 40,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30),
                                    color: const Color.fromARGB(255, 85, 85, 85)),
                                alignment: Alignment.center,
                                child: Text(
                                  "رسال",
                                  style: TextStyle(color: Colors.white),
                                )),
                          ),
                        ),
                        //her
                      ],
                    ),
                  ),
                ),
              ]))));
    });
  }
}
