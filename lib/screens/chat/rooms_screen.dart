import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rody_app/constants.dart';
import 'package:rody_app/controllers/auth/login_controller.dart';
import 'package:rody_app/controllers/chat/messages_controller.dart';
import 'package:rody_app/controllers/chat/room_controller.dart';
import 'package:rody_app/screens/chat/chat_screen.dart';
import 'package:web_socket_channel/status.dart' as status;

class MessageScreen extends StatefulWidget {
  MessageScreen({Key? key}) : super(key: key);

  @override
  State<MessageScreen> createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  RoomController roomController = Get.put(RoomController());
  MainController mainController = Get.put(MainController());
  MessagesController messagesController = Get.put(MessagesController());

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    roomController
        .getchannel(roomController.reciverId)
        .sink
        .close(status.goingAway);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: GetBuilder<RoomController>(
        init: RoomController(),
        initState: (_) {},
        builder: (roomController) {
          return Container(
            margin: EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "المحادثات",
                  style: TextStyle(
                      color: Colors.black45,
                      fontSize: 15,
                      fontWeight: FontWeight.bold),
                ),
                ListView.builder(
                    itemCount: roomController.rooms.length,
                    shrinkWrap: true,
                    itemBuilder: (BuildContext ctxt, int index) {
                      return Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10)),
                        margin: EdgeInsets.all(7),
                        child: ListTile(
                          onTap: () {
                            var reciverId;

                            roomController.rooms[index].user1 ==
                                    mainController.pk
                                ? reciverId = roomController.rooms[index].user2
                                : reciverId = roomController.rooms[index].user1;

                            messagesController.getMessages(reciverId,
                                mainController.userToken.read('token'));

                            Get.to(() => ChatScreen(
                                  reciverId: reciverId,
                                  chatTitle:
                                      roomController.rooms[index].user1 ==
                                              mainController.pk
                                          ? roomController.rooms[index].name2
                                          : roomController.rooms[index].name1,
                                ));
                          },
                          tileColor: primaryColor.withOpacity(0.1),
                          leading: roomController.rooms[index].user1 ==
                                  mainController.pk
                              ? Container(
                                  width: 50,
                                  child: Image.network(
                                      'https://rodyboutique.com${roomController.rooms[index].image2}'))
                              : Container(
                                  width: 50,
                                  child: roomController.rooms[index].image1 ==
                                          null
                                      ? Image.asset('images/Logo.png')
                                      : Image.network(
                                          'https://rodyboutique.com${roomController.rooms[index].image1}'),
                                ),
                          title: roomController.rooms[index].user1 ==
                                  mainController.pk
                              ? Text("${roomController.rooms[index].name2}")
                              : Text("${roomController.rooms[index].name1}"),
                        ),
                      );
                    }),
              ],
            ),
          );
        },
      ),
    );
  }
}
