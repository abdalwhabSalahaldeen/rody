import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:rody_app/controllers/auth/login_controller.dart';
import 'package:rody_app/models/chat/message_model.dart';

class MessagesController extends GetxController {
  List MessageList = [];
  MainController mainController = Get.put(MainController());
  getMessages(reciverId, token) async {
    var url = Uri.parse('https://rodyboutique.com/messages/$reciverId/');
    await http.get(url, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    }).then((response) {
      dynamic responseDecode = jsonDecode(utf8.decode(response.bodyBytes));
      print(responseDecode);
      for (var i = 0; i < responseDecode.length; i++) {
        MessageList.add(Message.fromJson(responseDecode['results'][i]));
        // print(responseDecode[i]['message']);
      }
      print("reciverId  : ");
      print(reciverId);
      print("sender id  : ");

      print("MessageList length : ");
      print(MessageList.length);

      if (response.statusCode == 200) {
      } else if (response.statusCode == 401) {
        //writeToken(null);
      } else {}
    });
    update();
  }

  @override
  void onInit() async {
    super.onInit();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }
}
