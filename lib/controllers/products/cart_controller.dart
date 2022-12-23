import 'dart:convert';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:rody_app/controllers/auth/login_controller.dart';
import 'package:rody_app/controllers/products/product_controller.dart';
import 'package:rody_app/models/products/products_model.dart';
import 'package:rody_app/screens/widgets.dart';

class AddToCart extends GetxController {
  GoogleMapController? mapController;
  Map<MarkerId, Marker> markers =
      <MarkerId, Marker>{}; // CLASS MEMBER, MAP OF MARKS

  Position? mylocation;
  LatLng _center = LatLng(9.669111, 80.014007);
  CameraPosition kGooglePlex = CameraPosition(
    target: LatLng(13, 31),
    zoom: 10,
  );
  var lat = 0.0;
  var long = 0.0;

  Future<Position> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    mylocation = await Geolocator.getCurrentPosition().then((value) {
      print(value.latitude);
      print(value.longitude);
      final Marker marker = Marker(
        markerId: MarkerId("test"),
        position: LatLng(value.latitude, value.longitude),
      );
      markers[MarkerId('place_name')] = marker;
    });

    update();

    return await Geolocator.getCurrentPosition();
  }

  MainController mainController = Get.put(MainController(), permanent: true);
  ProductsController productsController =
      Get.put(ProductsController(), permanent: true);
  List? lst;
  double totalPayment = 0;
  int quantity = 1;
  Product? product;
  var cartFlutter = GetStorage();
  List? quantityCartProductList;
  getProduct(productId) async {
    var url = Uri.parse('https://rodyboutique.com/api/products/$productId/');
    await http.get(url, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    }).then((response) {
      print(response.statusCode);
      dynamic responseDecode = jsonDecode(utf8.decode(response.bodyBytes));
      product = Product.fromJson(responseDecode);
      print(product);
    });
  }

  addquantity(productId) {
    if (quantityCartProductList == null) {
      print("clean quantityCartProductList");
      quantityCartProductList = [];
    }
    print("quantityCartProductLis start");
    // print(quantityCartProductList!.length);
    print((quantityCartProductList));
    if (quantityCartProductList != null &&
        quantityCartProductList!.isNotEmpty) {
      print("quantityCartProductList if");
      print(quantityCartProductList!.runtimeType);
      //  print((quantityCartProductList![0]["productId"]));
      var exists = quantityCartProductList!.firstWhere(
          (produ) => produ.productId == productId,
          orElse: () => null);
      // print("exists");
      if (exists != null) {
        exists.quantity = exists.quantity + 1;
        print(exists.quantity);
        // print(exists['quantity']);
      } else {
        print("quantityCartProductList else");
        // print(quantityCartProductList!.length);
        print((quantityCartProductList));
        quantityCartProductList!.add(QuantityCartProduct(
          quantity: quantity,
          productId: productId,
        ));
      }
    } else {
      print("quantityCartProductList else 2");
      // print(quantityCartProductList!.length);
      print((quantityCartProductList));
      quantityCartProductList!.add(QuantityCartProduct(
        quantity: 1,
        productId: productId,
      ));
    }
    // quantity = quantity + 1;
    print(quantity);

    update();
  }

  minumsquantity(productId) {
    if (quantityCartProductList == null) {
      print("clean quantityCartProductList");
      quantityCartProductList = [];
    }
    print("quantityCartProductLis start");
    // print(quantityCartProductList!.length);
    print((quantityCartProductList));
    if (quantityCartProductList != null &&
        quantityCartProductList!.isNotEmpty) {
      print("quantityCartProductList if");
      print(quantityCartProductList!.runtimeType);
      //  print((quantityCartProductList![0]["productId"]));
      var exists = quantityCartProductList!.firstWhere(
          (produ) => produ.productId == productId,
          orElse: () => null);
      // print("exists");
      if (exists != null) {
        exists.quantity = exists.quantity - 1;
        print(exists.quantity);
        // print(exists['quantity']);
      } else {
        print("quantityCartProductList else");
        // print(quantityCartProductList!.length);
        print((quantityCartProductList));
        quantityCartProductList!.add(QuantityCartProduct(
          quantity: quantity,
          productId: productId,
        ));
      }
    } else {
      print("quantityCartProductList else 2");
      // print(quantityCartProductList!.length);
      print((quantityCartProductList));
      quantityCartProductList!.add(QuantityCartProduct(
        quantity: 1,
        productId: productId,
      ));
    }
    // quantity = quantity + 1;
    print(quantity);
    update();
  }

  add(Product product, {quantity = 1}) {
    if (lst == null) {
      // print("clean lst");
      lst = [];
    }
    if (lst != null && lst!.isNotEmpty) {
      // print("lst");
      // print(lst!.length);
      // print((lst));
      var exists = lst!.firstWhere((produ) => produ['productId'] == product.id,
          orElse: () => null);
      // print("exists");
      if (exists != null) {
        exists['quantity'] = exists['quantity'] + quantity;
        // print(exists['quantity']);
      } else {
        lst!.add(CartFlutter(
                quantity: quantity,
                productId: product.id,
                rate: product.price,
                title: product.title,
                image: product.image,
                getCategory: product.getCategory)
            .toJson());
      }
    } else {
      lst!.add(CartFlutter(
              quantity: quantity,
              productId: product.id,
              rate: product.price,
              title: product.title,
              image: product.image,
              getCategory: product.getCategory)
          .toJson());
    }
    cartFlutter.write('productsInCartsLists', lst);
    showToastCostum("تم اضافة المنتج للسله", Toast.LENGTH_LONG);
    // print(cartFlutter.read("productsInCartsLists"));

    getTotalNow();
    // print("upate total");
    update();
  }

  minums(productId) {
    var exists = lst!.firstWhere((produ) => produ['productId'] == productId,
        orElse: () => null);
    // print("exists");
    if (exists != null) {
      exists['quantity'] = exists['quantity'] - 1;
    }
    update();
  }

  del(int index) {
    lst!.removeAt(index);

    update();
  }

  getTotalNow() {
    // print(lst);
    for (var i = 0; i < lst!.length; i++) {
      // print(lst![i]);
      totalPayment = lst![i]["quantity"] * lst![i]["rate"] + totalPayment;
    }
    // print(totalPayment);
    update();
  }

  cartSubmit() async {
    // print(mainController.userToken.read("token"));
    var url = Uri.parse("https://rodyboutique.com/api/carts/");
    await http
        .post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${mainController.userToken.read("token")}',
      },
      body: jsonEncode({"total": totalPayment, "customer": mainController.pk}),
    )
        .then((response) {
      if (response.statusCode == 201) {
        dynamic responseDecode = jsonDecode(response.body);
        orderSubmit(responseDecode['id']);

        // print(responseDecode['id']);
        // print("done");
      }
    });

    update();
  }

  orderSubmit(cartId) async {
    // print(mainController.userToken.read("token"));
    var url = Uri.parse("https://rodyboutique.com/api/orders/");
    await http
        .post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${mainController.userToken.read("token")}',
      },
      body: jsonEncode({
        "phone_customer": mainController.phoneNumber,
        "email": mainController.email,
        "subtotal": totalPayment,
        "total": totalPayment,
        "order_status": "الطلب لم يبداء",
        "payment_method": "after delvery",
        "payment_send": false,
        "location": "بحري",
        "payment_completed": false,
        "customer": mainController.pk,
        "cart": cartId
      }),
    )
        .then((response) {
      // print("ordering");
      // print(response.statusCode);
      if (response.statusCode == 201) {
        dynamic responseDecode = jsonDecode(response.body);

        for (var i = 0; i < lst!.length; i++) {
          cartProductSubmit(cartId, lst![i]["productId"], responseDecode['id'],
              false, lst![i]["rate"], lst![i]["quantity"]);
        }
        cartFlutter.remove("productsInCartsLists");
        showToastCostum(
            "تم آرسال الطلب ، سوف نتواصل معك خلال ١٢ ساعه", Toast.LENGTH_LONG);

        lst!.clear();
        totalPayment = 0.0;

        // print("done");
      }
    });

    update();
  }

  cartProductSubmit(
      cartId, productId, orderId, payment_completed, rate, quantity) async {
    // print(mainController.userToken.read("token"));
    var url = Uri.parse("https://rodyboutique.com/api/cartporduct/");
    await http
        .post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${mainController.userToken.read("token")}',
      },
      body: jsonEncode({
        "rate": rate,
        "quantity": quantity,
        "subtotal": rate * quantity,
        "order_status": "الطلب لم يبداء",
        "payment_completed": payment_completed,
        "order_id": orderId,
        "cart": cartId,
        "product": productId
      }),
    )
        .then((response) {
      // print("cartporduct");
      // print(response.statusCode);
      if (response.statusCode == 201) {
        dynamic responseDecode = jsonDecode(response.body);

        // print(responseDecode['id']);
        // print("done");
      }
    });

    update();
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  void onInit() {
    determinePosition();
    // TODO: implement onInit
    super.onInit();

    if (quantityCartProductList == null) {
      print("clean quantityCartProductList");
      quantityCartProductList = [];
    }

    lst = cartFlutter.read("productsInCartsLists");
    // print("lst init");
    if (lst != null && lst!.isNotEmpty) {
      getTotalNow();
    }
  }
}
