import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;

class Api {
  String ip = "https://mangamediaa.com/mango/public";
  TextEditingController email_employee = TextEditingController();
  TextEditingController password_employee = TextEditingController();
  late Box idbox = Hive.box("id");
  late Box namebox = Hive.box("name");
  late Box emailbox = Hive.box("email");
  late Box imagebox = Hive.box("image");
  late Box tokenbox = Hive.box("token");
  late Box specializationbox = Hive.box("specialization");
  late Box phonebox = Hive.box("phone");
  late Box salarybox = Hive.box("salary");
  var login;
  Future Login() async {
    login = null;
    String url = "$ip/api/employee/login";
    try {
      var response = await http.post(
        Uri.parse(url),
        body: {
          "email": "${email_employee.text.toString()}",
          "password": "${password_employee.text.toString()}"
        },
        headers: {
          'Accept': 'application/json',
        },
      );
      var responsebody = jsonDecode(response.body);

      if (responsebody.isNotEmpty) {
        login = responsebody;
        if (login['message'] == "employee Logged In Successfully") {
          idbox.put("id", "${login['data']['data']['id']}");
          namebox.put("name", "${login['data']['data']['name']}");
          emailbox.put("email", "${login['data']['data']['email']}");
          imagebox.put("image", "${login['data']['data']['iamge_baase64']}");
          tokenbox.put("token", "${login['data']['data']['token']}");

          specializationbox.put(
              "specialization", "${login['data']['data']['specialization']}");
          phonebox.put("phone", "${login['data']['data']['phone']}");
          salarybox.put("salary", "${login['data']['data']['salary']}");
          print("token==${tokenbox.get("token")}");
          print("token==${tokenbox.get("token")}");
          print("token==${tokenbox.get("token")}");
        }
      }
      print("responbody=====${responsebody}");
      print("responbody=====${responsebody}");
      print("responbody=====${responsebody}");
    } catch (e) {
      print(e);
    }
    return login;
  }

  var datataskesnotdon;
  Future GetTaskesNotDone() async {
    datataskesnotdon = null;
    String url = "$ip/api/employee/get-all-task-not-done";
    try {
      var response = await http.get(
        Uri.parse(url),
        headers: {
          'Accept': 'application/json',
          'Authorization': '${tokenbox.get("token")}',
        },
      );
      var responsebody = jsonDecode(response.body);

      if (responsebody.isNotEmpty) {
        datataskesnotdon = responsebody;
      }
      print("responbody=====${responsebody}");
      print("responbody=====${responsebody}");
      print("responbody=====${responsebody}");
    } catch (e) {
      print(e);
    }
    return datataskesnotdon;
  }

  var datataskesdon;
  Future GetTaskesDone() async {
    datataskesdon = null;
    String url = "$ip/api/employee/get-all-task-done";
    try {
      var response = await http.get(
        Uri.parse(url),
        headers: {
          'Accept': 'application/json',
          'Authorization': '${tokenbox.get("token")}',
        },
      );
      var responsebody = jsonDecode(response.body);

      if (responsebody.isNotEmpty) {
        datataskesdon = responsebody;
      }
      print("responbody=====${responsebody}");
      print("responbody=====${responsebody}");
      print("responbody=====${responsebody}");
    } catch (e) {
      print(e);
    }
    return datataskesdon;
  }

  var datataskesdetails;
  Future GetTaskesDetails(String task_type, int task_id) async {
    datataskesdetails = null;
    String url = "$ip/api/employee/get-order-details";
    try {
      var response = await http.post(
        Uri.parse(url),
        body: {"task_type": task_type, "task_id": task_id.toString()},
        headers: {
          'Accept': 'application/json',
          'Authorization': '${tokenbox.get("token")}',
        },
      );
      var responsebody = jsonDecode(response.body);

      if (responsebody.isNotEmpty) {
        datataskesdetails = responsebody;
      }
      print("responbody=====${responsebody}");
      print("responbody=====${responsebody}");
      print("responbody=====${responsebody}");
    } catch (e) {
      print(e);
    }
    return datataskesdetails;
  }

  var finish_task;
  Future FinishTask(String task_type, int task_id, int user_id,String status_finished) async {
    finish_task = null;
    String url = "$ip/api/employee/finish-order";
    try {
      var response = await http.post(
        Uri.parse(url),
        body: {
          "task_type": task_type,
          "task_id": task_id.toString(),
          "user_id": user_id.toString(),
          "accept": "true",
          "status_finished":status_finished
        },
        headers: {
          'Accept': 'application/json',
          'Authorization': '${tokenbox.get("token")}',
        },
      );
      var responsebody = jsonDecode(response.body);

      if (responsebody.isNotEmpty) {
        finish_task = responsebody;
      }
      print("responbody=====${responsebody}");
      print("responbody=====${responsebody}");
      print("responbody=====${responsebody}");
    } catch (e) {
      print(e);
    }
    return finish_task;
  }

  var user_data = null;
  Future GetUserData(int id) async {
    user_data = null;
    String url = "$ip/api/admin/get-all-user-data-poll/$id";
    try {
      var response = await http.get(
        Uri.parse(url),
        headers: {'Accept': 'application/json'},
      );
      if (!response.body.isEmpty) {
        var responsebody = jsonDecode(response.body);

        user_data = responsebody;

        print(responsebody.length);
        print(responsebody.length);
        print(responsebody);
        print(responsebody);
      }
    } catch (e) {
      print(e);
    }

    return user_data;
  }

  var user_order = null;
  Future GetUserOrders(int id) async {
    user_order = null;
    String url = "$ip/api/admin/get-all-user-order/$id";
    try {
      var response = await http.get(
        Uri.parse(url),
        headers: {'Accept': 'application/json'},
      );
      if (!response.body.isEmpty) {
        var responsebody = jsonDecode(response.body);
        user_order = responsebody;
        print(responsebody.length);
        print(responsebody.length);
        print(responsebody);
        print(responsebody);
      }
    } catch (e) {
      print(e);
    }

    return user_order;
  }
  TextEditingController search_client = TextEditingController();
  var search = null;
  Future Search() async {
    search = null;
    String url = "$ip/api/admin/search-user";
    try {
      var response = await http.post(
        Uri.parse(url),
        body: {
          "name": search_client.text,
        },
        headers: {'Accept': 'application/json'},
      );
      var responsebody = jsonDecode(response.body);

      if (responsebody.isNotEmpty) {
        search = responsebody;
      }
      print("search=====${search}");
      print("search=====${search}");
      print("search=====${search}");
    } catch (e) {
      print(e);
    }
    return search;
  }
  TextEditingController search_email_client = TextEditingController();
  var search_email = null;
  Future SearchEmail() async {
    search_email = null;
    String url = "$ip/api/admin/search-user-by-email";
    try {
      var response = await http.post(
        Uri.parse(url),
        body: {
          "email": search_email_client.text,
        },
        headers: {'Accept': 'application/json'},
      );
      var responsebody = jsonDecode(response.body);

      if (responsebody.isNotEmpty) {
        search_email = responsebody;
      }
      print("search_email=====${search_email}");
      print("search_email=====${search_email}");
      print("search_email=====${search_email}");
    } catch (e) {
      print(e);
    }
    return search_email;
  }
  TextEditingController search_phone_client = TextEditingController();
  var search_phone = null;
  Future SearchPhone() async {
    search_phone = null;
    String url = "$ip/api/admin/search-user-by-phone";
    try {
      var response = await http.post(
        Uri.parse(url),
        body: {
          "phone": search_phone_client.text,
        },
        headers: {'Accept': 'application/json'},
      );
      var responsebody = jsonDecode(response.body);

      if (responsebody.isNotEmpty) {
        search_phone = responsebody;
      }
      print("search_phone=====${search_phone}");
      print("search_phone=====${search_phone}");
      print("search_phone=====${search_phone}");
    } catch (e) {
      print(e);
    }
    return search_phone;
  }
  var imageprof;
  String image_base64 = '';
  Future uploudImageProfile(String token) async {
    imageprof = null;
    String url = "$ip/api/employee/edit/image";
    try {
      var response = await http.post(
        Uri.parse(url),
        body: {"iamge_baase64": "$image_base64"},
        headers: {'Accept': 'application/json', 'Authorization': '$token'},
      );
      var responsebody = jsonDecode(response.body);

      if (responsebody.isNotEmpty) {
        imageprof = responsebody;
      }
      print("responbody=====${responsebody}");
      print("responbody=====${responsebody}");
      print("responbody=====${responsebody}");
    } catch (e) {
      print(e);
    }
    return imageprof;
  }
  //GetAllNotification()
  var notification = null;
  Future GetAllNotification()async {
    notification = null;
    String url = "$ip/api/employee/get/all-notifications";
    try {
      var response = await http.get(
        Uri.parse(url),
        headers: {'Accept': 'application/json',
        "Authorization": tokenbox.get("token")
        },
      );
      if (!response.body.isEmpty) {
        var responsebody = jsonDecode(response.body);
        notification = responsebody;
        print(responsebody.length);
        print(responsebody.length);
        print(responsebody);
        print(responsebody);
      }
    } catch (e) {
      print(e);
    }

    return notification;
  }
  var count_notification = null;
  Future GetCountAllNotification() async {
    count_notification = null;
    String url = "$ip/api/employee/count/all-notifications";
    try {
      var response = await http.get(
        Uri.parse(url),
        headers: {'Accept': 'application/json', 'Authorization': tokenbox.get("token")},
      );
      if (!response.body.isEmpty) {
        var responsebody = jsonDecode(response.body);
        count_notification = responsebody;
        print(responsebody.length);
        print(responsebody.length);
        print(responsebody);
        print(responsebody);
      }
    } catch (e) {
      print(e);
    }

    return count_notification;
  }
  ///add campaign and reels
  //campain
  String order_type_campain = '';
  String target_campain = "";
  TextEditingController link_facebook_campain = TextEditingController();
  TextEditingController link_instgram_campain = TextEditingController();
  TextEditingController link_post_campain_facebook = TextEditingController();
  TextEditingController link_post_campain_instgram = TextEditingController();
  TextEditingController salaryforday_campain = TextEditingController();
  TextEditingController target_area_campain = TextEditingController();
  var compain;
  Future Campain(int user_id) async {
    compain = null;
    String url = "$ip/api/employee/advertising/campaign";
    try {
      var response = await http.post(
        Uri.parse(url),
        body: {
          "order_type": "$order_type_campain",
          "facebook_link": "${link_facebook_campain.text}",
          "instagram_link": "${link_instgram_campain.text}",
          "facebook_post_link": "${link_post_campain_facebook.text}",
          "instagram_post_link": "${link_post_campain_instgram.text}",
          "target": "$target_campain",
          "day_price": "${salaryforday_campain.text}",
          "target_area": "${target_area_campain.text}",
          "user_id": user_id.toString()
        },
        headers: {'Accept': 'application/json', 'Authorization': tokenbox.get('token')},
      );
      var responsebody = jsonDecode(response.body);

      if (responsebody.isNotEmpty) {
        compain = responsebody;
        order_type_campain = '';
        target_campain = '';
        target_area_campain.text = '';
        link_facebook_campain.text = '';
        link_instgram_campain.text = '';
        link_post_campain_facebook.text = '';
        link_post_campain_instgram.text = '';
        salaryforday_campain.text = '';
      }
      print("responbody=====${responsebody}");
      print("responbody=====${responsebody}");
      print("responbody=====${responsebody}");
    } catch (e) {
      print(e);
    }
    return compain;
  }

  //reals
  TextEditingController name_prodect = TextEditingController();
  String image_reals = '';
  TextEditingController description_prodect = TextEditingController();
  TextEditingController roude_usage_prodect = TextEditingController();
  TextEditingController salary_prodect = TextEditingController();
  TextEditingController offers_prodect = TextEditingController();
  TextEditingController gift_prodect = TextEditingController();
  var reals;
  Future Reals(int user_id) async {
    reals = null;
    String url = "$ip/api/employee/advertising/reels";
    try {
      var response = await http.post(
        Uri.parse(url),
        body: {
          "product_name": "${name_prodect.text.toString()}",
          "product_image": "$image_reals",
          "product_description": "${description_prodect.text.toString()}",
          "product_usage": "${roude_usage_prodect.text.toString()}",
          "product_price": "${salary_prodect.text.toString()}",
          "offers": "${offers_prodect.text.toString()}",
          "gift": "${gift_prodect.text.toString()}",
          "user_id":user_id.toString()
        },
        headers: {'Accept': 'application/json', 'Authorization': tokenbox.get('token')},
      );
      var responsebody = jsonDecode(response.body);

      if (responsebody.isNotEmpty) {
        reals = responsebody;
      }
      print("responbody=====${responsebody}");
      print("responbody=====${responsebody}");
      print("responbody=====${responsebody}");
    } catch (e) {
      print(e);
    }
    return reals;
  }

}
