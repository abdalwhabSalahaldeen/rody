import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:async';
import 'package:rody_app/constants.dart';
import 'package:rody_app/controllers/auth/login_controller.dart';
import 'package:rody_app/controllers/products/cart_controller.dart';
import 'package:rody_app/screens/widgets.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';

class MyCartScreen extends StatelessWidget {
  MyCartScreen({Key? key}) : super(key: key);

  static final CameraPosition _kLake = CameraPosition(
    bearing: 192.8334901395799,
    target: LatLng(12.8628, 30.2176),
    zoom: 10,
  );

  AddToCart addToCart = Get.put(AddToCart(), permanent: true);
  Completer<GoogleMapController> _controller = Completer();

  @override
  Widget build(BuildContext context) {
    //print(addToCart.cartFlutter.read("productsInCartsLists").length);

    return GetBuilder<AddToCart>(
        init: AddToCart(),
        initState: (_) {},
        builder: (addToCart) {
          if (addToCart.cartFlutter.read("productsInCartsLists") != null ||
              addToCart.cartFlutter.read("productsInCartsLists") == []) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                // TextButton(
                //   onPressed: () {
                //     addToCart.determinePosition();
                //   },
                //   child: Text("تحديد موقعي"),
                // ),
                // SizedBox(
                //   height: 300,
                //   child: GoogleMap(
                //     mapType: MapType.normal,
                //     initialCameraPosition: addToCart.kGooglePlex,
                //     markers: addToCart.markers.values.toSet(),
                //     onMapCreated: (GoogleMapController controller) {
                //       addToCart.mapController = controller;
                //     },
                //   ),
                // ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: AutoSizeText("سلة المشتريات",
                      style: TextStyle(
                        fontSize: 23,
                      )),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: ListView.separated(
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return Container(
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: Image.network(addToCart.cartFlutter
                                          .read("productsInCartsLists")[index]
                                      ['image']),
                                ),
                                Expanded(
                                  flex: 3,
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        right: 10.0, left: 8.0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                            "${addToCart.cartFlutter.read("productsInCartsLists")[index]['title']}"),
                                        Text(
                                          "${addToCart.cartFlutter.read("productsInCartsLists")[index]['rate']} \$",
                                          style: TextStyle(
                                            fontSize: 23,
                                            fontWeight: FontWeight.bold,
                                            color: primaryColor,
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            IconButtonCostum(35.0, 35.0,
                                                () async {
                                              await addToCart.minums(
                                                  addToCart.cartFlutter.read(
                                                          "productsInCartsLists")[
                                                      index]['productId']);
                                            }, Icon(Icons.remove)),
                                            Container(
                                              padding: EdgeInsets.only(
                                                  right: 30,
                                                  left: 30,
                                                  top: 10,
                                                  bottom: 5),
                                              child: Text(
                                                "${addToCart.cartFlutter.read("productsInCartsLists")[index]['quantity']}",
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                            IconButtonCostum(35.0, 35.0,
                                                () async {
                                              await addToCart.getProduct(
                                                  addToCart.cartFlutter.read(
                                                          "productsInCartsLists")[
                                                      index]['productId']);
                                              await addToCart
                                                  .add(addToCart.product!);
                                            }, Icon(Icons.add)),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                        separatorBuilder: (context, index) {
                          return Divider(
                            height: 20,
                          );
                        },
                        itemCount: addToCart.cartFlutter
                            .read("productsInCartsLists")
                            .length),
                  ),
                ),
                Center(
                  child: MaterialButton(
                    minWidth: MediaQuery.of(context).size.width - 30.0,
                    textColor: Colors.white,
                    onPressed: () {
                      addToCart.cartSubmit();
                    },
                    color: primaryColor,
                    elevation: 0.0,
                    child: Text("اكمال الطلب"),
                  ),
                ),
                Center(
                  child: MaterialButton(
                    minWidth: MediaQuery.of(context).size.width - 30.0,
                    textColor: Colors.white,
                    onPressed: () {
                      addToCart.cartSubmit();
                    },
                    color: secondColor,
                    elevation: 0.0,
                    child: Text("افراغ السله "),
                  ),
                ),
                SizedBox(
                  height: 15.0,
                ),
              ],
            );
          } else {
            return Center(child: Text(" السله فارغه"));
          }
        });
  }
}
