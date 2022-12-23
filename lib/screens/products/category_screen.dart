import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rody_app/controllers/products/product_controller.dart';
import 'package:rody_app/models/products/categorys_model.dart';
import 'package:rody_app/screens/widgets.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class CategoryScreen extends StatelessWidget {
  Category category;
  RefreshController refreshController =
      RefreshController(initialRefresh: false);
  CategoryScreen({Key? key, required this.category}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(category.title);
    return Scaffold(
      appBar: AppBar(
        title: AutoSizeText("${category.title}"),
      ),
      body: GetBuilder<ProductsController>(
        init: ProductsController(),
        initState: (_) {},
        builder: (productsController) {
          print("productController.next");
          print(productsController.next);
          if (productsController.next != null) {
            print("you can load more");
          }
          return ProductSliderCategory(
              productsController.enablePullUp,
              MediaQuery.of(context).size.height,
              category.id,
              refreshController,
              Axis.vertical,
              productsController.productsfliter,
              productsController,
              377.0,
              MediaQuery.of(context).size.width * .95,
              MediaQuery.of(context).size.width * .95,
              260.0);
        },
      ),
    );
  }
}
