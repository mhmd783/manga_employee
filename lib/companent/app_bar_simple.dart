import 'package:employee_mango/view/employee/dialog_edit.dart';
import 'package:employee_mango/view/employee/dialog_logout.dart';
import 'package:employee_mango/view/employee/dialog_notification.dart';
import 'package:flutter/material.dart';
import 'package:employee_mango/companent/colors.dart';
import 'package:employee_mango/prov/prov.dart';
import 'package:provider/provider.dart';

class AppBarAppSimple extends StatelessWidget {
  AppBarAppSimple({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    ColorsApp colorsApp = new ColorsApp();
    return Consumer<control>(builder: (context, val, child) {
      return Container(
        width: MediaQuery.of(context).size.width,
        margin: EdgeInsets.all(10),
        child: Row(
          children: [
            CircleAvatar(
              child: IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: Icon(Icons.keyboard_arrow_left)),
            ),
            Expanded(child: Container()),
            //logo

            Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [colorsApp.colorlogo1, colorsApp.colorlogo2],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(30)),
              child: CircleAvatar(
                radius: 25,
                backgroundColor: Colors.white.withOpacity(0.0),
                child: Image.asset("assets/images/mango.png"),
              ),
            ),
            // pages app
          ],
        ),
      );
    });
  }
}

class AppBarEmployee extends StatelessWidget {
  AppBarEmployee({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    ColorsApp colorsApp = new ColorsApp();
    DialogLogOut dialogLogOut = new DialogLogOut();
    DialogEdit dialogEdit = new DialogEdit();
    DialogNotification dialogNotification = new DialogNotification();
    return Consumer<control>(builder: (context, val, child) {
      return Container(
        width: MediaQuery.of(context).size.width,
        margin: EdgeInsets.all(10),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: Colors.grey,
              child: IconButton(
                  onPressed: () {
                    dialogLogOut.logout(context);
                  },
                  icon: Icon(Icons.person_2_outlined)),
            ),
            SizedBox(
              width: 10,
            ),
            CircleAvatar(
              backgroundColor: Colors.grey,
              child: IconButton(
                  onPressed: () {
                    dialogEdit.editImage(context);
                  },
                  icon: Icon(Icons.edit)),
            ),
            SizedBox(
              width: 10,
            ),
            Stack(
              children: [
                CircleAvatar(
                  backgroundColor: Colors.grey,
                  child: IconButton(
                      onPressed: () {
                        // val.GetAllNotification();
                        // dialogNotification.Notification(context);
                        Navigator.of(context).pushNamed("notification");
                      },
                      icon: Icon(Icons.notification_important_outlined)),
                ),
                val.count_notification!=null? val.count_notification['message']=="Notifications Count"?val.count_notification['data']>0?CircleAvatar(
                  backgroundColor: colorsApp.color_grean_body,
                  radius: 5,
                ):SizedBox():SizedBox():SizedBox()
              ],
            ),
            SizedBox(
              width: 10,
            ),
            CircleAvatar(
              backgroundColor: Colors.grey,
              child: IconButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed("search");
                  },
                  icon: Icon(Icons.search)),
            ),
            Expanded(child: Container()),
            //logo

            Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [colorsApp.colorlogo1, colorsApp.colorlogo2],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(30)),
              child: CircleAvatar(
                radius: 25,
                backgroundColor: Colors.white.withOpacity(0.0),
                child: Image.asset("assets/images/mango.png"),
              ),
            ),
            // pages app
          ],
        ),
      );
    });
  }
}
