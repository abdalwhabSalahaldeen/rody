import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rody_app/constants.dart';
import 'package:rody_app/controllers/auth/login_controller.dart';
import 'package:rody_app/controllers/control/slider_controller.dart';
import 'package:rody_app/controllers/products/category_controller.dart';
import 'package:rody_app/controllers/products/product_controller.dart';
import 'package:rody_app/screens/products/category_screen.dart';
import 'package:rody_app/screens/widgets.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:carousel_slider/carousel_slider.dart';

class HomeBodyScreen extends StatelessWidget {
  SliderController sliderController =
      Get.put(SliderController(), permanent: true);

  CategorysController categorysController =
      Get.put(CategorysController(), permanent: true);

  ProductsController productsController =
      Get.put(ProductsController(), permanent: true);

  HomeBodyScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.all(0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GetBuilder<SliderController>(
              initState: (_) {},
              builder: (sliderController) {
                return CarouselSlider(
                  options: CarouselOptions(
                    height: 170.0,
                    enableInfiniteScroll: true,
                    reverse: false,
                    autoPlay: true,
                    autoPlayCurve: Curves.easeInCubic,
                  ),
                  items: sliderController.sliders.map((i) {
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
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(right: 12.0),
              child: AutoSizeText("الاقسام",
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  )),
            ),
            SizedBox(
              height: 10,
            ),
            GetBuilder<CategorysController>(
              initState: (_) {},
              builder: (categorysController) {
                return Container(
                  alignment: Alignment.center,
                  height: 110,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      itemCount: categorysController.categorys.length,
                      itemBuilder: (context, index) {
                        return Container(
                          margin: EdgeInsets.only(right: 10),
                          width: 110,
                          decoration: BoxDecoration(
                              color: primaryColor.withOpacity(0.6),
                              borderRadius: BorderRadius.circular(5)),
                          child: InkWell(
                            onTap: () {
                              categorysController.getProductsCategory(
                                  categorysController.categorys[index].id);

                              Get.to(() => CategoryScreen(
                                  category:
                                      categorysController.categorys[index]));
                            },
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(
                                  width: 70,
                                  height: 70,
                                  child: Image.network(
                                      "${categorysController.categorys[index].image}"),
                                ),
                                AutoSizeText(
                                  "${categorysController.categorys[index].title}",
                                  style: TextStyle(fontSize: 15),
                                ),
                              ],
                            ),
                          ),
                        );
                      }),
                );
              },
            ),
            SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.only(right: 12.0),
              child: AutoSizeText("منتجات جديدة",
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  )),
            ),
            SizedBox(
              height: 10,
            ),
            GetBuilder<ProductsController>(
              initState: (_) {},
              builder: (productsController) {
                return ProductSlider(
                    productsController,
                    377.0,
                    MediaQuery.of(context).size.width * 0.8,
                    MediaQuery.of(context).size.width * 0.8,
                    260.0);
              },
            ),
            SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.only(right: 12.0),
              child: AutoSizeText("افضل المنتجات",
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  )),
            ),
            SizedBox(
              height: 10,
            ),
            GetBuilder<ProductsController>(
              initState: (_) {},
              builder: (productsController) {
                return ProductSlider(
                    productsController,
                    240.0,
                    MediaQuery.of(context).size.width * 0.43,
                    MediaQuery.of(context).size.width * 0.43,
                    110.0);
              },
            ),
            SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.only(right: 12.0),
              child: AutoSizeText("الاكثر مشاهده",
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  )),
            ),
            SizedBox(
              height: 10,
            ),
            GetBuilder<ProductsController>(
              initState: (_) {},
              builder: (productsController) {
                return ProductSlider(
                    productsController,
                    240.0,
                    MediaQuery.of(context).size.width * 0.43,
                    MediaQuery.of(context).size.width * 0.43,
                    110.0);
              },
            ),
            SizedBox(
              height: 40,
            ),
          ],
        ),
      ),
    );
  }
}
