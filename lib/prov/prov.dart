import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:employee_mango/prov/api.dart';
import 'package:image_picker/image_picker.dart';

class control extends ChangeNotifier {
  Api api = new Api();
  String body_employee = "todaytaskes";
  changeBodyEmployee(String body) {
    body_employee = body;

    notifyListeners();
  }

  //user
  String body_client = "data";
  //data /order
  changBodyProfileClient(String body) {
    body_client = body;
    notifyListeners();
  }

  //api
  //login
  var login = null;
  Login() async {
    login = null;
    login = await api.Login();

    print("datalogin=====${login}");
    print("datalogin=====${login}");
    print("datalogin=====${login}");
    notifyListeners();
  }

  Logout() {
    api.tokenbox.put("token", null);
    api.imagebox.put("image", null);
    notifyListeners();
  }

  var datataskes = null;
  GetTaskesNotDone() async {
    datataskes = null;
    datataskes = await api.GetTaskesNotDone();
    print("datalogin=====${datataskes}");
    print("datalogin=====${datataskes}");
    print("datalogin=====${datataskes}");
    notifyListeners();
  }

  GetTaskesDone() async {
    datataskes = null;
    datataskes = await api.GetTaskesDone();
    print("datalogin=====${datataskes}");
    print("datalogin=====${datataskes}");
    print("datalogin=====${datataskes}");
    notifyListeners();
  }

  var datataskesdetails = null;
  GetTaskesDetails(String task_type, int task_id) async {
    image_client_campain = null;
    image_client = null;
    image_client_reals = null;
    image_reals = null;
    datataskesdetails = null;
    datataskesdetails = await api.GetTaskesDetails(task_type, task_id);

    if (task_type == "reels") {
      if (datataskesdetails != null) {
        if (datataskesdetails['message'] == "Reels Data") {
          if (datataskesdetails['data']['product_image'] != "null") {
            await storimage();
          }
        }
      }
    } else {
      if (datataskesdetails != null) {
        if (datataskesdetails['message'] == "Campaign Data") {
          if (datataskesdetails['data']['user']['iamge_baase64'] != "null") {
            await storimageClientCampaign();
          }
        }
      }
    }
    print("datataskesdetails=====${datataskesdetails}");
    print("datataskesdetails=====${datataskesdetails}");
    print("datataskesdetails=====${datataskesdetails}");
    notifyListeners();
  }

  //image reals
  File? image_reals = null;
  Future storimage() async {
    image_reals = null;
    List<int> imageBytes =
        base64Decode(datataskesdetails['data']['product_image']);
    image_reals =
        await _storeImageToFile(imageBytes, datataskesdetails['data']['id']);

    if (datataskesdetails['data']['user']['iamge_baase64'] != "null") {
      await storimageClientReals();
    }
    notifyListeners();
  }

  Future<File> _storeImageToFile(List<int> imageBytes, int id) async {
    //get id to stor image by defrent image
    String tempPath = Directory.systemTemp.path;

    File file = File('$tempPath/image${id}reels.jpg');
    await file.writeAsBytes(imageBytes);
    print('image${file.path} ///$tempPath');
    print('image${file.path}///$tempPath');
    return file;
  }

  //image_client_reals
  File? image_client_reals = null;
  Future storimageClientReals() async {
    image_client_reals = null;
    List<int> imageBytes =
        base64Decode(datataskesdetails['data']['user']['iamge_baase64']);
    image_client_reals = await _storeImageClientRealsToFile(
        imageBytes, datataskesdetails['data']['user_id']);
    notifyListeners();
  }

  Future<File> _storeImageClientRealsToFile(
      List<int> imageBytes, int id) async {
    String tempPath = Directory.systemTemp.path;
    File file = File('$tempPath/image${id}clientreelse.jpg');
    await file.writeAsBytes(imageBytes);
    print('image===${file.path} ///$tempPath');
    print('image===${file.path}///$tempPath');
    return file;
  }

  //image_client_campaign
  File? image_client_campain = null;
  Future storimageClientCampaign() async {
    image_client_campain = null;
    List<int> imageBytes =
        base64Decode(datataskesdetails['data']['user']['iamge_baase64']);
    image_client_campain = await _storeImageClientCampaignToFile(
        imageBytes, datataskesdetails['data']['id']);
    notifyListeners();
  }

  Future<File> _storeImageClientCampaignToFile(
      List<int> imageBytes, int id) async {
    String tempPath = Directory.systemTemp.path;
    File file = File('$tempPath/image${id}campaign.jpg');
    await file.writeAsBytes(imageBytes);
    print('image===${file.path} ///$tempPath');
    print('image===${file.path}///$tempPath');
    return file;
  }

  int task_id = 0;
  int user_id = 0;
  String task_type = '';
  var finish_task = null;
  FinishTask(String status_finished) async {
    finish_task = null;
    finish_task =
        await api.FinishTask(task_type, task_id, user_id, status_finished);
    if (finish_task != null) {
      if (finish_task['message'] == "Campaign Canceled Done" ||
          finish_task['message'] == "Campaign Done" ||
          finish_task['message'] == "Reels Done" ||
          finish_task['message'] == "Reels Canceled Done") {
        //
        GetTaskesDetails(task_type, task_id);
        GetTaskesNotDone();
      }
    }
    print("finish_task=====${finish_task}");
    print("finish_task=====${finish_task}");
    print("finish_task=====${finish_task}");
    notifyListeners();
  }

  var user_data = null;
  int id_user = 0;
  GetUserData() async {
    user_data = null;
    user_data = await api.GetUserData(id_user);
    if (user_data != null) {
      if (user_data['message'] == "User data retrieved successfully.") {
        //image_base64:
        if (user_data['data']['image_base64'] != "null") {
          storimageClient();
        }
      }
    }
    print("datacompain=====${user_data}");
    print("datacompain=====${user_data}");
    print("datacompain=====${user_data}");
    notifyListeners();
  }

  //image_client
  File? image_client = null;
  Future storimageClient() async {
    image_client = null;
    List<int> imageBytes = base64Decode(user_data['data']['image_base64']);
    image_client =
        await _storeImageClientToFile(imageBytes, user_data['data']['user_id']);
    notifyListeners();
  }

  Future<File> _storeImageClientToFile(List<int> imageBytes, int id) async {
    String tempPath = Directory.systemTemp.path;
    File file = File('$tempPath/image$id.jpg');
    await file.writeAsBytes(imageBytes);
    print('image===${file.path} ///$tempPath');
    print('image===${file.path}///$tempPath');
    return file;
  }

  var user_orders = null;
  GetUserOrders() async {
    user_orders = null;
    user_orders = await api.GetUserOrders(id_user);
    print("datacompain=====${user_orders}");
    print("datacompain=====${user_orders}");
    print("datacompain=====${user_orders}");
    notifyListeners();
  }

  var search = null;

  Future Search() async {
    search = null;
    search = await api.Search();
    print("search=====${search}");
    print("search=====${search}");
    print("search=====${search}");
    notifyListeners();
  }
  Future SearchEmail() async {
    search = null;
    search = await api.SearchEmail();
    print("search_email=====${search}");
    print("search_email=====${search}");
    print("search_email=====${search}");
    notifyListeners();
  }Future SearchPhone() async {
    search = null;
    search = await api.SearchPhone();
    print("search_email=====${search}");
    print("search_email=====${search}");
    print("search_email=====${search}");
    notifyListeners();
  }

  //get image
  File? imageprofile;
  String base64imageprofile = '';
  var pickedImageprofile;
  final imagePickerprofile = ImagePicker();

  Future<void> getPhotoProfile() async {
    pickedImageprofile =
        await imagePickerprofile.pickImage(source: ImageSource.gallery);
    if (pickedImageprofile != null) {
      imageprofile = File(pickedImageprofile.path);
      List<int> imagebytesprofile =
          File(pickedImageprofile.path).readAsBytesSync();
      base64imageprofile = base64Encode(imagebytesprofile);
      debugPrint(base64imageprofile);
      print("length:${base64imageprofile.length}");
      print("length:${base64imageprofile.length}");
    } else {
      print("not chose image");
      // إعلان خيار آخر في حالة عدم تحديد صورة
      // يمكنك إضافة المزيد من العمليات هنا بناءً على حالتك
    }
    notifyListeners();
  }

  var imageprof = null;
  uploudImageProfile() async {
    imageprof = null;
    api.image_base64 = base64imageprofile;
    imageprof = await api.uploudImageProfile(api.tokenbox.get('token'));
    if (imageprof != null) {
      if (imageprof['message'] == "Image Updated successfully.") {
        api.imagebox.put("image", base64imageprofile);
        await ProsessIamgeProfile();
      }
    }

    print("imageprofile=====${imageprof}");
    print("imageprofile=====${imageprof}");
    print("imageprofile=====${imageprof}");
    notifyListeners();
  }
  //prosess image profile

  File? image_profile = null;
  Future ProsessIamgeProfile() async {
    image_profile = null;
    List<int> imageBytes = base64Decode(api.imagebox.get("image"));
    if (api.imagebox.get("image") != null &&
        api.imagebox.get("image") != "null") {
      image_profile =
          await _storeImageToFile(imageBytes, Random().nextInt(100));

      print("convert image");
      print("convert image");
      print(api.imagebox.get("image"));
      print("convert image");
      print("convert image");
    }

    notifyListeners();
  }

  Future<File> _storeImageToFileProfile(List<int> imageBytes, int id) async {
    //get id to stor image by defrent image
    String tempPath = Directory.systemTemp.path;

    File file = File('$tempPath/image/profile$id.jpg');
    await file.writeAsBytes(imageBytes);
    print('image${file.path} ///$tempPath');
    print('image${file.path}///$tempPath');
    return file;
  }

  var notification = null;
  Future GetAllNotification() async {
    notification = null;
    notification = await api.GetAllNotification();
    GetCountAllNotification();
    notifyListeners();
  }

  var count_notification = null;
  GetCountAllNotification() async {
    count_notification = null;
    count_notification = await api.GetCountAllNotification();
    print("count_notification=====${count_notification}");
    print("count_notification=====${count_notification}");
    print("count_notification=====${count_notification}");
    notifyListeners();
  }

  //add campaign reels
  ChoseTypeCampain(String camp) {
    api.order_type_campain = camp;
    print(camp);
    notifyListeners();
  }
  choseDropDowenItemsGoal(String value) {
    api.target_campain = value;
    print(api.target_campain);
    notifyListeners();
  }
  String selectedGoal =  "الهدف من الحمله";
  List<dynamic> dropdownItemsGoal = [
      "زياده عدد المتابعين",
      "زياده التفاعل",
      "تلقي المزيد من الرسائل",
      "جزب المزيد من الزوار"
    ];
  DropDowenCampain() {
    dropdownItemsGoal = [
      "زياده عدد المتابعين",
      "زياده التفاعل",
      "تلقي المزيد من الرسائل",
      "جزب المزيد من الزوار"
    ];
    selectedGoal =  "الهدف من الحمله";
    notifyListeners();
  }
  var campain = null;
  Camapain() async {
    campain = null;
    //for select value chose
    //message //The advertising campaign has been requested successfully. We will contact you
    print("goal ${api.target_campain}");
    print("area ${api.target_area_campain}");
    campain = await api.Campain(user_id);
    
    print("datacompain=====${campain}");
    print("datacompain=====${campain}");
    print("datacompain=====${campain}");
    notifyListeners();
  }

  //reals
  //get image
  File? image;
  String base64image = '';
  var pickedImage;
  final imagePicker = ImagePicker();
  Future<void> getphoto() async {
    pickedImage = await imagePicker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      image = File(pickedImage.path);
      List<int> imagebytes = File(pickedImage.path).readAsBytesSync();
      base64image = base64Encode(imagebytes);
      debugPrint(base64image);
      print("length:${base64image.length}");
      print("length:${base64image.length}");
    } else {
      print("not chose image");
      // إعلان خيار آخر في حالة عدم تحديد صورة
      // يمكنك إضافة المزيد من العمليات هنا بناءً على حالتك
    }
    notifyListeners();
  }
  var reals = null;
  Reals() async {
    reals = null;
    api.image_reals = base64image;
    reals = await api.Reals(user_id);
    if (reals != null) {
      api.name_prodect.text = '';
      api.image_reals = '';
      api.description_prodect.text = '';
      api.roude_usage_prodect.text = '';
      api.salary_prodect.text = '';
      api.offers_prodect.text = '';
      api.gift_prodect.text = '';
      image = null;
      base64image = '';
    }
    print("reels=====${reals}");
    print("reels=====${reals}");
    print("reels=====${reals}");
    notifyListeners();
  }
}
