import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:rody_app/controllers/auth/login_controller.dart';
import 'package:rody_app/models/chat/rooms_model.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:web_socket_channel/status.dart' as status;

class RoomController extends GetxController {
  var mainController = Get.put(MainController());
  var rooms = [];
  var reciverId;

  WebSocketChannel getchannel(reciverId) {
    return IOWebSocketChannel.connect(
        "ws://192.168.43.96:8000/ws/chat/$reciverId/");
  }

  getRooms(pk, token) async {
    print("get rooms");
    reciverId = pk;
    var url = Uri.parse('https://rodyboutique.com/rooms/$pk/');
    await http.get(url, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    }).then((response) {
      dynamic responseDecode = jsonDecode(utf8.decode(response.bodyBytes));

      // return reciver user to show image and name in messages screen

      for (var i = 0; i < responseDecode['results'].length; i++) {
        rooms.add(Room.fromJson(responseDecode['results'][i]));
        print(Room.fromJson(responseDecode['results'][i]).name1);
      }
      print(rooms);

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
    await getRooms(mainController.pk, mainController.userToken.read('token'));
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
    getchannel(reciverId).sink.close(status.goingAway);
    rooms.clear();
  }
}
