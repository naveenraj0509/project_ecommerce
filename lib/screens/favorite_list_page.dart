import 'package:flutter/material.dart';
import 'package:project_ecommerce/models/product_grid_model.dart';
import 'package:project_ecommerce/utils/constants.dart';

class FavoriteList extends StatefulWidget {
  const FavoriteList({super.key});

  @override
  State<FavoriteList> createState() => _FavoriteListState();
}

class _FavoriteListState extends State<FavoriteList> {
  List<ProductGridModel> favouriteList = [];

  @override
  void initState() {
    favouriteList = Constants.productList
        .where(
          (element) => element.isFavourite == true,).toList();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade400,
      body: (favouriteList.isEmpty)
          ? Center(
              child: Text(
                "Favorite List is empty",
                style: TextStyle(
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
              ),
            )
          : SingleChildScrollView(
              physics: PageScrollPhysics(),
              child: Column(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 1.5,
                    child: ListView.builder(
                      physics: PageScrollPhysics(),
                      itemCount: favouriteList.length,
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return Card(
                          color: Colors.blueGrey.shade400,
                          elevation: 5,
                          child: Row(
                            // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Image(
                                  image: NetworkImage(
                                      favouriteList[index].images[0]),
                                  height: 100,
                                  width: 100,
                                ),
                              ),
                              SizedBox(
                                width: 220,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    RichText(
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                      text: TextSpan(
                                        text: '${favouriteList[index].prdName}',
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16),
                                      ),
                                    ),
                                    RichText(
                                      text: TextSpan(
                                        text: "\$${favouriteList[index].price}",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 22),
                                      ),
                                    ),
                                    Column(
                                      children: [
                                        SizedBox(
                                          width: 500,
                                        ),
                                        GestureDetector(
                                          onTap: () => setState(() {
                                            favouriteList[index].isFavourite =
                                                !favouriteList[index]
                                                    .isFavourite;
                                            favouriteList.removeAt(index);

                                          }),
                                          child: Container(
                                            height: 40,
                                            width: 40,
                                            margin: EdgeInsets.all(7),
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: Colors.grey,
                                            ),
                                            child: Icon(
                                                favouriteList[index].isFavourite
                                                    ? Icons.favorite
                                                    : Icons
                                                        .favorite_border_outlined,
                                                color: Colors.white),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
