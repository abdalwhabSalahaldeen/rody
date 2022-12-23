import 'package:auto_size_text/auto_size_text.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:rody_app/constants.dart';
import 'package:rody_app/controllers/products/cart_controller.dart';
import 'package:rody_app/controllers/products/images_controller.dart';
import 'package:rody_app/controllers/products/product_controller.dart';
import 'package:rody_app/models/products/products_model.dart';
import 'package:rody_app/screens/widgets.dart';

class ProductDetails extends StatelessWidget {
  Product product;
  ProductsController productsController =
      Get.put(ProductsController(), permanent: true);
  int q = 1;
  var exists;
  ImagesController imagesController =
      Get.put(ImagesController(), permanent: true);
  AddToCart addToCart = Get.put(AddToCart(), permanent: true);
  ProductDetails({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    imagesController.getImages(product.id);

    return Scaffold(
      appBar: AppBar(
        title: Text("${product.title}"),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GetBuilder<ImagesController>(
              init: ImagesController(),
              initState: (_) {},
              builder: (imagesController) {
                return CarouselSlider(
                  options: CarouselOptions(
                    height: 250.0,
                    viewportFraction: 1,
                    enableInfiniteScroll: true,
                    reverse: false,
                    autoPlay: true,
                    autoPlayCurve: Curves.easeInCubic,
                  ),
                  items: imagesController.images.map((i) {
                    return Builder(
                      builder: (BuildContext context) {
                        return Container(
                            width: MediaQuery.of(context).size.width,
                            margin: EdgeInsets.symmetric(horizontal: 5.0),
                            decoration: BoxDecoration(color: Colors.amber),
                            child: Image.network(
                              "${i.image}",
                              fit: BoxFit.fill,
                            ));
                      },
                    );
                  }).toList(),
                );
              },
            ),
            GetBuilder<ProductsController>(
              init: ProductsController(),
              initState: (_) {},
              builder: (productController) {
                return Container(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 15,
                      ),
                      AutoSizeText(
                        "${product.title}",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          RatingBar.builder(
                            initialRating: product.getRate,
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
                          Spacer(),
                          AutoSizeText(
                            "السعر : ${product.price} \$",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      AutoSizeText(
                        "التفاصيل",
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 12.0, top: 12.0),
                        child: AutoSizeText(
                          "${product.description}",
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButtonCostum(35.0, 35.0, () {
                              addToCart.minumsquantity(product.id);
                            }, Icon(Icons.remove)),
                            GetBuilder<AddToCart>(
                              initState: (_) {},
                              builder: (addToCart) {
                                exists = addToCart.quantityCartProductList!
                                    .firstWhere(
                                        (produ) =>
                                            produ.productId == product.id,
                                        orElse: () => null);
                                print(exists);
                                if (exists != null) {
                                  return Container(
                                    padding: EdgeInsets.only(
                                        right: 30,
                                        left: 30,
                                        top: 10,
                                        bottom: 5),
                                    child: Text(
                                      "${exists.quantity}",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  );
                                } else {
                                  return Container(
                                    padding: EdgeInsets.only(
                                        right: 30,
                                        left: 30,
                                        top: 10,
                                        bottom: 5),
                                    child: Text(
                                      "1",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  );
                                }
                              },
                            ),
                            IconButtonCostum(35.0, 35.0, () {
                              addToCart.addquantity(product.id);
                            }, Icon(Icons.add)),
                          ],
                        ),
                      ),
                      Center(
                        child: MaterialButton(
                          minWidth: MediaQuery.of(context).size.width - 30.0,
                          textColor: Colors.white,
                          onPressed: () {
                            exists = addToCart.quantityCartProductList!
                                .firstWhere(
                                    (produ) => produ.productId == product.id,
                                    orElse: () => null);
                            if (exists != null) {
                              q = exists.quantity;
                              exists.quantity = 1;
                            }
                            print(q);
                            addToCart.add(product, quantity: q);
                            q = 1;
                          },
                          color: primaryColor,
                          elevation: 0.0,
                          child: Text("اضف للسله"),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
