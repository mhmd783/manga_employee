import 'package:flutter/material.dart';
import 'package:employee_mango/companent/colors.dart';
import 'package:employee_mango/prov/prov.dart';
import 'package:provider/provider.dart';

class DialogEdit {
  ColorsApp colorApp = new ColorsApp();

  //edit image
  Future<void> editImage(BuildContext context) async {
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
                      height: 40,
                      width: 40,
                      child: Image.asset("assets/images/mango.png"),
                    ),
                    Container(
                      height: 50,
                      width:
                           150 ,
                      child: Image.asset(
                         
                            "assets/images/mangomedia.png",
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
                    //add image
                    MaterialButton(
                      onPressed: () {
                        val.getPhotoProfile();
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
                        child: val.imageprofile == null
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
                                  Text( 'اضافه صوره')
                                ],
                              )
                            : Image.file(val.imageprofile!),
                      ),
                    ),
                  ],
                )),
            actions: <Widget>[
              Consumer<control>(builder: (context, val, child) {
                return Row(
                  children: [
                    Container(
                      alignment: Alignment.center,
                      height: 30,
                      width: 80,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: colorApp.color_yellow_body,
                      ),
                      child: MaterialButton(
                        child: Text("تاكيد",
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () {
                          val.uploudImageProfile();
                          Navigator.of(context).pop();
                          checkEditImage(context);
                        },
                      ),
                    ),
                    Expanded(child: Container()),
                    Consumer<control>(builder: (context, val, child) {
                      return Container(
                        alignment: Alignment.center,
                        height: 30,
                        width: 80,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: colorApp.color_yellow_body,
                        ),
                        child: MaterialButton(
                          child: Text( "الغاء",
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
              }),
            ],
          );
        });
      },
    );
  }

  Future<void> checkEditImage(BuildContext context) async {
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
                      height: 40,
                      width: 40,
                      child: Image.asset("assets/images/mango.png"),
                    ),
                    Container(
                      height: 50,
                      width: 150,
                      child: Image.asset("assets/images/mangomedia.png",
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
                        child: val.imageprof == null
                            ? CircularProgressIndicator(
                                color: colorApp.color_yellow_body,
                              )
                            : val.imageprof['message'] ==
                                    "Image Updated successfully."
                                ? Text( "تم رفع الصوره",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: colorApp.color_grean_body))
                                : Text( "خطاء",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.red))),
                  ],
                )),
            actions: <Widget>[
              val.imageprof == null
                  ? Consumer<control>(builder: (context, val, child) {
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
                  : val.imageprof['message'] == "Image updated successfully."
                      ? Consumer<control>(builder: (context, val, child) {
                          return Container(
                            alignment: Alignment.center,
                            padding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 5),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: colorApp.color_yellow_body,
                            ),
                            child: MaterialButton(
                              child: Text( "تم",
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
                              color: colorApp.color_yellow_body,
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
