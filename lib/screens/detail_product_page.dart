import 'package:carousel_slider/carousel_slider.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:project_ecommerce/screens/bottom_nav_bar_page.dart';
import 'package:project_ecommerce/screens/home_page.dart';
import 'package:project_ecommerce/models/get_cart_list_model.dart';
import 'package:project_ecommerce/models/get_single_product_model.dart';
import 'package:project_ecommerce/screens/my_cart_page.dart';
import 'package:project_ecommerce/utils/constants.dart';
import 'package:project_ecommerce/widgets/text_field_widget.dart';
import 'package:widgets_easier/widgets_easier.dart';

import '../models/get_all_products_model.dart';

class DetailProductPage extends StatefulWidget {
  final int productIndex;
  final Product productDetail;

  const DetailProductPage({
    super.key,
    required this.productIndex,
    required this.productDetail,
  });

  @override
  State<DetailProductPage> createState() => _DetailProductPageState();
}

class _DetailProductPageState extends State<DetailProductPage> {
  int quantity = 0;
  Dio dio = Dio();

  GetSingleProductModel? detailedProductModel;
  GetCartListModel? cartListModel;

  bool isLoading = true;
  //${widget.productDetail.id}
  bool isProductInCart = false;
  getSingleProduct() async {
    final response = await dio.get(
      "https://dummyjson.com/products/",
    );

    if (response.statusCode == 200) {
      detailedProductModel = GetSingleProductModel.fromJson(response.data);
      cartListModel = GetCartListModel.fromJson(response.data);
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    getSingleProduct();

    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.grey.shade400,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.grey,
        leading: GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const BottomNavBarPage(),
                  ));
            },
            child: Icon(Icons.arrow_back_outlined),
        ),
        title: Text(
          "Detail Product",
          style: TextStyle(fontWeight: FontWeight.w700),
        ),
        actions: [Icon(Icons.shopping_cart), SizedBox(width: 20)],
      ),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              physics: PageScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListView(
                    physics: PageScrollPhysics(),
                    shrinkWrap: true,
                    children: [
                      CarouselSlider.builder(
                        itemCount: detailedProductModel?.images?.length,
                        itemBuilder: (context, index, realIndex) {
                          return Container(
                            margin: EdgeInsets.all(0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.0),
                              image: DecorationImage(
                                image: NetworkImage(
                                    widget.productDetail.images?[0] ?? ""),
                                fit: BoxFit.cover,
                              ),
                            ),
                          );
                        },
                        options: CarouselOptions(
                          height: 400,
                          enlargeCenterPage: true,
                          autoPlay: true,
                          aspectRatio: 16 / 9,
                          autoPlayCurve: Curves.fastOutSlowIn,
                          enableInfiniteScroll: true,
                          autoPlayAnimationDuration:
                              Duration(milliseconds: 1000),
                          viewportFraction: 1.1,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              widget.productDetail.brand.toString(),
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: Colors.blueGrey,
                                  fontSize: 18),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Icon(Icons.star, color: Colors.yellow),
                            SizedBox(width: 5),
                            Text(
                              "(",
                              style: TextStyle(
                                  color: Colors.grey.shade300, fontSize: 20),
                            ),
                            Text(
                              widget.productDetail.rating.toString(),
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: Colors.grey.shade300,
                                  fontSize: 18),
                            ),
                            Text(
                              ")",
                              style: TextStyle(
                                  color: Colors.grey.shade300, fontSize: 20),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          widget.productDetail.title.toString(),
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                            fontSize: 20,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Text(
                              "\$",
                              style: TextStyle(
                                  fontSize: 22,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500),
                            ),
                            SizedBox(
                              width: 3,
                            ),
                            Text(
                              "32.99",
                              style: TextStyle(
                                  decoration: TextDecoration.lineThrough,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black,
                                  fontSize: 22),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              "\$ ${widget.productDetail.price}",
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black,
                                  fontSize: 22),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            ClipPath(
                              clipper: OvalRightBorderClipper(),
                              child: Container(
                                height: 50,
                                width: 80,
                                color: Colors.green,
                                child: Center(
                                    child: Text(
                                  "67 % ",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 22,
                                      fontWeight: FontWeight.w900),
                                )),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Free delivery",
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Deliver to : ",
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        child: Text(
                                          "WeCodeLife,Ground Floor, Pallippat Dew, Kadavil Ln, Nethaji Nagar, Edappally, Kochi, Ernakulam, Kerala 682024",
                                          style: TextStyle(fontSize: 14),
                                          softWrap: true,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10))),
                                        onPressed: () {},
                                        child: const Text(
                                          "change",
                                          style: TextStyle(
                                              color: Colors.blueGrey,
                                              fontSize: 16),
                                        ),
                                      ),
                                    ],
                                  ),
                                ]),
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              SizedBox(
                                width: 10,
                              ),

                              GestureDetector(
                                onTap: () {
                                  bool productExists = false;
                                  for (int i = 0; i < Constants.checkOutList.length; i++) {
                                    if (Constants.checkOutList[i].id == widget.productDetail.id) {
                                      Constants.checkOutList[i].quantity = (Constants.checkOutList[i].quantity! + 1);
                                      productExists = true;
                                      break;
                                    }
                                  }
                                  if (!productExists) {
                                    Constants.checkOutList.add(GetCartListModel(
                                      id: widget.productDetail.id,  // Ensure ID is included for proper checking
                                      title: widget.productDetail.title,
                                      price: widget.productDetail.price,
                                      images: widget.productDetail.images,
                                      quantity: 1,
                                    ));
                                  }

                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => const MyCartPage()),
                                  );
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      border: Border.all(),
                                      color: Colors.white),
                                  height: 60,
                                  width: 180,
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.card_travel,
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          "ADD TO CART",
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w800,
                                              color: Colors.black),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 30,
                              ),
                              Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    border: Border.all(),
                                    color: Colors.blueGrey),
                                height: 60,
                                width: 180,
                                child: Center(
                                    child: Text(
                                  "BUY NOW",
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.white),
                                )),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
