import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:project_ecommerce/screens/detail_product_page.dart';
import 'package:project_ecommerce/models/category_story_model.dart';
import 'package:project_ecommerce/models/get_all_products_model.dart';
import 'package:project_ecommerce/models/product_grid_model.dart';
import 'package:project_ecommerce/screens/my_cart_page.dart';
import 'package:project_ecommerce/utils/constants.dart';
import 'package:project_ecommerce/widgets/category_story_widget.dart';
import 'package:project_ecommerce/widgets/product_grid_widget.dart';
import 'package:project_ecommerce/widgets/text_field_widget.dart';

import 'category_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Dio dio = Dio();
  GetAllProductsModel? productsModel;
  bool isLoading = true;

  getProduct() async {
    final response = await dio.get(
      "https://dummyjson.com/products",
    );

    if (response.statusCode == 200) {
      productsModel = GetAllProductsModel.fromJson(response.data);
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    getProduct();

    // TODO: implement initState
    super.initState();
  }

  final List<CategoryStoryModel> categorystory = [
    CategoryStoryModel(image: "assets/images/men.jpg", name: "Men"),
    CategoryStoryModel(image: "assets/images/women.jpg", name: "Women"),
    CategoryStoryModel(image: "assets/images/shades.jpeg", name: "Sunglasses"),
    CategoryStoryModel(
        image: "assets/images/motorcycle.jpg", name: "Motorcycle"),
    CategoryStoryModel(
        image: "assets/images/mobile_phone.jpg", name: "Smartphones"),
    CategoryStoryModel(image: "assets/images/laptops.jpeg", name: "Laptops"),
    CategoryStoryModel(
        image: "assets/images/mobile-accessories.jpg",
        name: "Mobile Acessories")
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey.shade400,
        appBar: AppBar(
          backgroundColor: Colors.grey,
          leading: Image.asset('assets/images/18Sep24-removebg-preview.png',
              fit: BoxFit.cover),
          leadingWidth: 80,
          actions: [
            GestureDetector(onTap:() {
              Navigator.push(context, MaterialPageRoute(builder: (context) => MyCartPage(),));
            } ,
              child: Icon(Icons.add_shopping_cart),
            ),
            SizedBox(
              width: 20,
            )
          ],
        ),
        body: isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : SingleChildScrollView(
                physics: ScrollPhysics(),
                child: Container(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFieldWidget(
                          Text: "Search",
                          prefixIcon: Icons.search,
                          contentPadding: EdgeInsets.symmetric(vertical: 10),
                          fillColor: Colors.black12,
                          hintTextColor: Colors.blueGrey,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 15),
                        child: ListView(
                          physics: PageScrollPhysics(),
                          shrinkWrap: true,
                          children: [
                            CarouselSlider(
                              items: [
                                //1st Image of Slider
                                Container(
                                  margin: EdgeInsets.all(6.0),
                                  decoration: BoxDecoration(
                                    // color: Colors.red,
                                    borderRadius: BorderRadius.circular(8.0),
                                    image: DecorationImage(
                                      image: NetworkImage(
                                          "https://i.pinimg.com/736x/fc/79/3b/fc793babb4bcb872f515efa9394e7df8.jpg"),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),

                                //2nd Image of Slider
                                Container(
                                  margin: EdgeInsets.all(6.0),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8.0),
                                    image: DecorationImage(
                                      image: NetworkImage(
                                          "https://i.pinimg.com/736x/4b/22/86/4b22867e1c2cc0e640db9ef6d6de2bc3.jpg"),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),

                                // 3rd Image of Slider
                                Container(
                                  margin: EdgeInsets.all(6.0),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8.0),
                                    image: DecorationImage(
                                      image: NetworkImage(
                                          "https://i.pinimg.com/736x/5b/b8/ad/5bb8ad83dcef2d944d9ffaaf163342f0.jpg"),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),

                                //4th Image of Slider
                                Container(
                                  margin: EdgeInsets.all(6.0),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8.0),
                                    image: DecorationImage(
                                      image: NetworkImage(
                                          "https://i.pinimg.com/736x/37/84/08/37840842216139312fe81b7f6a87879a.jpg"),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ],

                              //Slider Container properties
                              options: CarouselOptions(
                                height: 180,
                                enlargeCenterPage: true,
                                autoPlay: true,
                                aspectRatio: 16 / 9,
                                autoPlayCurve: Curves.fastOutSlowIn,
                                enableInfiniteScroll: true,
                                autoPlayAnimationDuration:
                                    Duration(milliseconds: 800),
                                viewportFraction: 0.9,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            right: 250, top: 10, bottom: 20),
                        child: Text("Shop by Category",
                            style: TextStyle(
                                fontWeight: FontWeight.w900,
                                fontSize: 18,
                                color: Colors.black)),
                      ),
                      SizedBox(
                        height: 120,
                        child: ListView.builder(
                          physics: PageScrollPhysics(),
                          itemCount: categorystory.length,
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return CategoryStoryWidget(
                                image: AssetImage(categorystory[index].image),
                                name: categorystory[index].name);
                          },
                        ),
                      ),
                      GridView.builder(
                        shrinkWrap: true,
                        padding: EdgeInsets.zero,
                        physics: PageScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 5,
                            mainAxisSpacing: 5,
                            childAspectRatio: 0.88),
                        itemCount: productsModel!.products!.length,
                        //productsModel?.products?.length,
                        itemBuilder: (context, index) {
                          return ProductGridWidget(
                            productData: productsModel!.products![index],
                            productIndex: index,
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => DetailProductPage(
                                      productIndex: index,
                                      productDetail:
                                          productsModel!.products![index],
                                    ),
                                  ));
                            },
                          );
                        },
                      ),
                      SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
              ));
  }
}
