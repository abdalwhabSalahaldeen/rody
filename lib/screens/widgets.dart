import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:rody_app/constants.dart';
import 'package:rody_app/screens/auth/login_screen.dart';
import 'package:rody_app/screens/products/product_details.dart';
import 'package:fluttertoast/fluttertoast.dart';

Container IconButtonCostum(h, w, onPressed, icon) {
  return Container(
    height: h,
    width: w,
    decoration: BoxDecoration(
        color: Colors.grey, borderRadius: BorderRadius.circular(10)),
    child: IconButton(
      padding: EdgeInsets.zero,
      iconSize: 15,
      color: Colors.white,
      onPressed: onPressed,
      icon: icon,
    ),
  );
}

void showToastCostum(String msg, toastLength) {
  Fluttertoast.showToast(
    msg: msg,
    toastLength: toastLength,
    fontSize: 14.0,
    gravity: ToastGravity.BOTTOM,
    backgroundColor: primaryColor,
    textColor: Colors.white,
  );
}

ElevatedButton DefaultButton(String text, onPressed) {
  return ElevatedButton(
      child: Text('$text'),
      style: ButtonStyle(
        elevation: MaterialStateProperty.all(0),
        padding: MaterialStateProperty.all(const EdgeInsets.all(15)),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18.0),
            //   side: BorderSide(
            //    color: Colors.white,
            //)
          ),
        ),
      ),
      onPressed: onPressed);
}

InkWell defaultTextButton(String text) {
  return InkWell(
    child: AutoSizeText("$text"),
  );
}

Container ProductSlider(
    productsController, height, size, imagewidth, imageheight) {
  print(productsController.products.length);
  return Container(
    alignment: Alignment.center,
    height: height,
    child: ListView.builder(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemCount: productsController.products.length,
        itemBuilder: (context, index) {
          return Container(
            margin: EdgeInsets.only(right: 10),
            width: size,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 0,
                  blurRadius: 5,
                  offset: Offset(0, 0),
                  // changes position of shadow
                ),
              ],
            ),
            child: InkWell(
              onTap: () {
                print("click me");
                Get.to(
                  () => ProductDetails(
                      product: productsController.products[index]),
                );
              },
              child: Column(
                children: [
                  Stack(
                    children: [
                      SizedBox(
                        width: imagewidth,
                        height: imageheight,
                        child: Image.network(
                          "${productsController.products[index].image}",
                          fit: BoxFit.fill,
                        ),
                      ),
                      Positioned(
                        left: 0,
                        top: 5,
                        child: Container(
                          decoration: BoxDecoration(
                            color: primaryColor,
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(10),
                              bottomRight: Radius.circular(10),
                            ),
                          ),
                          padding: EdgeInsets.only(top: 8, right: 8, left: 8),
                          child: Text(
                              "\$ ${productsController.products[index].price}"),
                        ),
                      ),
                    ],
                  ),
                  Spacer(),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 0),
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: Padding(
                            padding:
                                const EdgeInsets.only(right: 12, bottom: 5),
                            child: AutoSizeText(
                              "${productsController.products[index].title}",
                              maxLines: 2,
                              maxFontSize: 15,
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.w500),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(right: 10, bottom: 0),
                        child: RatingBar.builder(
                          initialRating:
                              productsController.products[index].getRate,
                          itemSize: 20,
                          minRating: 1,
                          direction: Axis.horizontal,
                          allowHalfRating: true,
                          itemCount: 5,
                          itemPadding: EdgeInsets.symmetric(horizontal: 2.0),
                          itemBuilder: (context, _) => Icon(
                            Icons.star,
                            color: Colors.amber,
                          ),
                          onRatingUpdate: (rating) {
                            print(rating);
                          },
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            onPressed: () {
                              productsController.favoriteOnPressed(
                                  productsController.products[index].id);
                            },
                            icon:
                                Icon(Icons.favorite_border, color: Colors.red),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: AutoSizeText(
                                "${productsController.products[index].getCategory}"),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        }),
  );
}

SmartRefresher ProductSliderCategory(
    enablePullUp,
    deviceheight,
    filter,
    RefreshController refreshController,
    axis,
    list,
    productsController,
    height,
    size,
    imagewidth,
    imageheight) {
  return SmartRefresher(
    enablePullDown: true,
    enablePullUp: enablePullUp,
    controller: refreshController,
    header: WaterDropHeader(),
    onRefresh: () async {
      print("loading onRefresh");

      //  await productsController.getProducts(filter: filter);
      refreshController.loadComplete();
    },
    onLoading: () async {
      print("loading now");
      // await productsController.getProducts(filter: filter);
      refreshController.loadComplete();
    },
    child: ListView.builder(
        scrollDirection: axis,
        shrinkWrap: true,
        itemCount: list.length,
        itemBuilder: (context, index) {
          return Container(
            margin: EdgeInsets.only(right: 10, bottom: 15),
            width: size,
            height: height,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 0,
                  blurRadius: 5,
                  offset: Offset(0, 0),
                  // changes position of shadow
                ),
              ],
            ),
            child: InkWell(
              onTap: () {
                print("click me");

                Get.to(
                  () => ProductDetails(
                      product: productsController.products[index]),
                );
              },
              child: Column(
                children: [
                  Stack(
                    children: [
                      SizedBox(
                        width: imagewidth,
                        height: imageheight,
                        child: Image.network(
                          "${list[index].image}",
                          fit: BoxFit.fill,
                        ),
                      ),
                      Positioned(
                        left: 0,
                        top: 5,
                        child: Container(
                          decoration: BoxDecoration(
                            color: primaryColor,
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(10),
                              bottomRight: Radius.circular(10),
                            ),
                          ),
                          padding: EdgeInsets.only(top: 8, right: 8, left: 8),
                          child: Text("\$ ${list[index].price}"),
                        ),
                      ),
                    ],
                  ),
                  Spacer(),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 0),
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: Padding(
                            padding:
                                const EdgeInsets.only(right: 12, bottom: 5),
                            child: AutoSizeText(
                              "${list[index].title}",
                              maxLines: 2,
                              maxFontSize: 15,
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.w500),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(right: 10, bottom: 0),
                        child: RatingBar.builder(
                          initialRating: list[index].getRate,
                          itemSize: 20,
                          minRating: 1,
                          direction: Axis.horizontal,
                          allowHalfRating: true,
                          itemCount: 5,
                          itemPadding: EdgeInsets.symmetric(horizontal: 2.0),
                          itemBuilder: (context, _) => Icon(
                            Icons.star,
                            color: Colors.amber,
                          ),
                          onRatingUpdate: (rating) {
                            print(rating);
                          },
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            onPressed: () {
                              productsController
                                  .favoriteOnPressed(list[index].id);
                            },
                            icon:
                                Icon(Icons.favorite_border, color: Colors.red),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: AutoSizeText("${list[index].getCategory}"),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        }),
  );
}

TextFormField TextFormCostumField(textInputType, TextEditingController login,
    bool obscureText, Function onChanged, String label, String hintText) {
  return TextFormField(
    style: TextStyle(),
    onChanged: (value) {
      onChanged(value);
    },
    controller: login,
    maxLength: 25,
    autofocus: true,
    obscureText: obscureText,
    cursorHeight: 15,
    keyboardType: textInputType,
    decoration: InputDecoration(
      floatingLabelBehavior: FloatingLabelBehavior.always,
      contentPadding:
          new EdgeInsets.symmetric(vertical: 15.0, horizontal: 15.0),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      hintText: '$hintText',
      hintStyle: TextStyle(fontSize: 14),
      label: Text("$label"),
    ),
  );
}
