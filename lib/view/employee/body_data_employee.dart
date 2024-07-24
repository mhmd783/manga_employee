import 'package:flutter/material.dart';
import 'package:employee_mango/companent/colors.dart';
import 'package:employee_mango/prov/prov.dart';
import 'package:provider/provider.dart';

class BodyDataEmployee extends StatelessWidget {
  BodyDataEmployee({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    ColorsApp colorsApp = new ColorsApp();
    return Consumer<control>(builder: (context, val, child) {
      return Container(
        margin: EdgeInsets.all(20),
        width: 500,
        //height: 300,
        decoration: BoxDecoration(
            border: Border.all(
                color: Colors.black,
                width: 1,
                style: BorderStyle.solid,
                strokeAlign: BorderSide.strokeAlignCenter),
            borderRadius: BorderRadius.circular(30)),
        child: Column(
          children: [
            ListTile(
              leading: Text(
                  "${val.api.namebox.get("name")}" //"${val.one_employee['name']}"
                  ),
              trailing: Text("الاسم"),
            ),
            Divider(
              color: Colors.grey.shade300,
              height: 2,
            ),
            ListTile(
              leading: Text(
                  "${val.api.specializationbox.get("specialization")}" //"${val.one_employee['specialization']}"
                  ),
              trailing: Text("المسمي الوظيفي"),
            ),
            Divider(
              color: Colors.grey.shade300,
              height: 2,
            ),
            ListTile(
              leading: Text(
                  "${val.api.emailbox.get("email")}" //"${val.one_employee['email']}"
                  ),
              trailing: Text("الايميل"),
            ),
            Divider(
              color: Colors.grey.shade300,
              height: 2,
            ),
            ListTile(
              leading: Text(
                  "${val.api.phonebox.get("phone")}" //"${val.one_employee['phone']}"
                  ),
              trailing: Text("رقم الهاتف"),
            ),
            Divider(
              color: Colors.grey.shade300,
              height: 2,
            ),
            ListTile(
              leading: Text(
                  "${val.api.salarybox.get("salary")}" //"${val.one_employee['salary']}"
                  ),
              trailing: Text("الراتب"),
            ),
          ],
        ),
      );
    });
  }
}
