import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:rody_app/constants.dart';
import 'package:rody_app/controllers/notifcation/notifcation_controller.dart';

class Natifaction extends StatelessWidget {
  Natifaction({Key? key}) : super(key: key);
  NotifcationController notifcationController =
      Get.put(NotifcationController(), permanent: true);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: GetBuilder<NotifcationController>(
      initState: (_) {},
      builder: (notifcationController) {
        return Container(
          height: MediaQuery.of(context).size.height,
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: notifcationController.notifcations.length,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {},
                child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: primaryColor.withOpacity(0.1),
                    ),
                    margin: EdgeInsets.all(7),
                    padding:
                        EdgeInsets.only(right: 18, left: 18, top: 7, bottom: 7),
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.notifications,
                              size: 20,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            AutoSizeText(
                              "${notifcationController.notifcations[index].title}",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 15),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        AutoSizeText(
                            "${notifcationController.notifcations[index].body}"),
                      ],
                    )),
              );
            },
          ),
        );
      },
    ));
  }
}
