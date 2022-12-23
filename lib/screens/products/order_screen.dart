import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rody_app/constants.dart';
import 'package:rody_app/controllers/products/orders_controller.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: GetBuilder<OrdersController>(
        init: OrdersController(),
        initState: (_) {},
        builder: (ordersController) {
          return ListView.separated(
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return ListTile(
                  onTap: () {},
                  title: AutoSizeText(
                      "رقم الطلب :  ${ordersController.orders[index].id}"),
                  subtitle: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AutoSizeText(
                          "تاريخ الطلب :  ${ordersController.orders[index].createdAt}"),
                      AutoSizeText(
                          "مكان التوصيل  :  ${ordersController.orders[index].location}"),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          AutoSizeText(
                              "حاله الطلب :  ${ordersController.orders[index].orderStatus}"),
                          AutoSizeText(
                              "المبلغ الكلي  :  ${ordersController.orders[index].total}"),
                          IconButton(onPressed: () {}, icon: Icon(Icons.print)),
                        ],
                      ),
                      // InkWell(
                      //   onTap: () {
                      //     print("click print");
                      //   },
                      //   child: Container(
                      //     decoration: BoxDecoration(
                      //       color: primaryColor.withOpacity(0.4),
                      //       borderRadius: BorderRadius.circular(15),
                      //     ),
                      //     child: Row(
                      //       mainAxisSize: MainAxisSize.min,
                      //       children: [
                      //         // Padding(
                      //         //   padding: const EdgeInsets.only(right: 12.0),
                      //         //   child: AutoSizeText("طباعة الفاتورة"),
                      //         // ),
                      //         IconButton(
                      //             onPressed: () {}, icon: Icon(Icons.print)),
                      //       ],
                      //     ),
                      //   ),
                      // ),
                    ],
                  ),
                );
              },
              separatorBuilder: (context, index) {
                return Divider();
              },
              itemCount: ordersController.orders.length);
        },
      ),
    );
  }

  Widget orderStateWidget(orderstate, context) {
    Color color = Colors.green;
    if (orderstate == "الطلب ملغي") {
      color = Colors.red;
    } else if (orderstate == "الطلب لم يبداء") {
      color = Colors.blue;
    }

    return Container(
      decoration: BoxDecoration(
        color: color.withOpacity(0.3),
        borderRadius: BorderRadius.circular(15),
      ),
      width: 150,
      height: 45,
      child: Center(child: AutoSizeText("${orderstate}")),
    );
  }
}
