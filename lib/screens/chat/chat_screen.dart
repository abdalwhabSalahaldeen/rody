import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rody_app/constants.dart';
import 'package:rody_app/controllers/auth/login_controller.dart';
import 'package:rody_app/controllers/chat/messages_controller.dart';
import 'package:rody_app/controllers/chat/room_controller.dart';
import 'package:rody_app/screens/chat/widget/message_widget_costum.dart';

class ChatScreen extends StatefulWidget {
  var reciverId;
  var chatTitle;
  ChatScreen({this.reciverId, this.chatTitle});
  final mainController = Get.put(MainController());
  RoomController roomController = Get.put(RoomController());
  MessagesController messagesController = Get.put(MessagesController());

  var childreen;

  @override
  ChatScreenState createState() {
    return ChatScreenState();
  }
}

class ChatScreenState extends State<ChatScreen> {
  TextEditingController _controller = TextEditingController();
  var _controllerList = ScrollController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration(milliseconds: 250), () {
      _controllerList.jumpTo(_controllerList.position.maxScrollExtent);
    });

    widget.childreen = [
      GetBuilder<MessagesController>(
          init: MessagesController(),
          initState: (_) {},
          builder: (_) {
            return ListView.builder(
                shrinkWrap: true,
                itemCount: _.MessageList.length,
                itemBuilder: (BuildContext ctxt, int index) {
                  return MessageWidgetCostum(
                      _.MessageList[index].senderId !=
                                  widget.mainController.pk &&
                              _.MessageList[index].reciverId ==
                                  widget.mainController.pk
                          ? TextDirection.ltr
                          : TextDirection.rtl,
                      _.MessageList[index].senderId !=
                                  widget.mainController.pk &&
                              _.MessageList[index].reciverId ==
                                  widget.mainController.pk
                          ? Color(0xFFffffff).withOpacity(0.8)
                          : Color(0xFF1b2e43).withOpacity(0.8),
                      _.MessageList[index].senderId !=
                                  widget.mainController.pk &&
                              _.MessageList[index].reciverId ==
                                  widget.mainController.pk
                          ? Color(0xFF1b2e43).withOpacity(0.8)
                          : Color(0xFFffffff).withOpacity(0.8),
                      _.MessageList[index].message);
                });
          })
    ];
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    widget.messagesController.MessageList.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("${widget.chatTitle}"),
        ),
        backgroundColor: Color(0xfff5f6f1),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              child: StreamBuilder<dynamic>(
                  stream:
                      widget.roomController.getchannel(widget.reciverId).stream,
                  builder:
                      (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                    print('$snapshot');
                    if (snapshot.hasData) {
                      print(json.decode(snapshot.data));
                      print(json.decode(snapshot.data).runtimeType);
                      print(json.decode(snapshot.data)['message']);
                      var message = json.decode(snapshot.data)['message'];
                      var reciverId = json.decode(snapshot.data)['reciverId'];
                      var senderId = json.decode(snapshot.data)['senderId'];
                      var direction = TextDirection.rtl;
                      var chatBackground = Color(0xFFffffff).withOpacity(0.8);

                      //print(jsonDecode(json.decode(snapshot.data[0])));
                      // var responseDecode = jsonDecode(utf8.decode(snapshot.data));
                      // print(responseDecode.runtimeType);
                      if (senderId == widget.mainController.pk) {
                        direction = TextDirection.rtl;
                        chatBackground = Color(0xFF1b2e43).withOpacity(0.8);
                      } else if (senderId != widget.mainController.pk &&
                          reciverId == widget.mainController.pk) {
                        direction = TextDirection.ltr;
                      }
                      print(senderId);
                      print(reciverId);
                      print(widget.mainController.pk);

                      widget.childreen.add(MessageWidgetCostum(
                          direction,
                          chatBackground,
                          senderId != widget.mainController.pk &&
                                  reciverId == widget.mainController.pk
                              ? Color(0xFF1b2e43).withOpacity(0.8)
                              : Color(0xFFFFFFFF).withOpacity(0.8),
                          message));
                    }

                    return Expanded(
                      child: ClipRRect(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30),
                        ),
                        child: ListView.builder(
                            shrinkWrap: true,
                            controller: _controllerList,
                            itemCount: widget.childreen.length,
                            itemBuilder: (BuildContext ctxt, int index) {
                              return widget.childreen[index];
                            }),
                      ),
                    );
                  }),
            ),
            Container(
              margin: EdgeInsets.only(right: 0, left: 0),
              color: Colors.transparent,
              child: Form(
                child: TextFormField(
                  controller: _controller,
                  decoration: InputDecoration(
                      suffixIcon: IconButton(
                        onPressed: _sendMessage,
                        icon: Icon(
                          Icons.send,
                          color: Colors.black,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(0)),
                          borderSide: BorderSide(
                              color: Color(0xFF1b2e43).withOpacity(0.8),
                              width: 0)),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(0)),
                          borderSide: BorderSide(
                              color: Color(0xFF1b2e43).withOpacity(0.8),
                              width: 2)),
                      filled: true,
                      hintTextDirection: TextDirection.rtl,
                      fillColor: secondColor,
                      contentPadding: EdgeInsets.all(15)),
                ),
              ),
            ),
          ],
        ));
  }

  //  funstions
  void _sendMessage() async {
    if (_controller.text.isNotEmpty) {
      widget.roomController.getchannel(widget.reciverId).sink.add(
          '{ "room":${widget.reciverId} ,"message": "${_controller.text}", "reciverId": ${widget.reciverId}, "senderId":${widget.mainController.pk}}');
    }

    _controller.clear();
    Future.delayed(Duration(milliseconds: 250), () {
      _controllerList.jumpTo(_controllerList.position.maxScrollExtent);
    });
  }
}
