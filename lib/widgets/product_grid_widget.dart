import 'package:flutter/material.dart';
import 'package:project_ecommerce/models/get_all_products_model.dart';
import 'package:project_ecommerce/utils/constants.dart';

class ProductGridWidget extends StatefulWidget {
  final int productIndex;
  final Function onTap;
  final Product productData;

  const ProductGridWidget({
    super.key,
    required this.productIndex,
    required this.onTap,
    required this.productData,
  });

  @override
  State<ProductGridWidget> createState() => _GridViewWidgetState();
}

class _GridViewWidgetState extends State<ProductGridWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.onTap();
      },
      child: Stack(children: <Widget>[
        Container(
          margin: EdgeInsets.all(3),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 160,
                width: 200,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: [Colors.grey, Colors.blueGrey, Colors.yellow]),
                ),
                child: Card(
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  semanticContainer: true,
                  borderOnForeground: true,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5)),
                  elevation: 5,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Image(
                      image: NetworkImage(
                        widget.productData.images?[0] ?? "",
                      ),
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    widget.productData.brand.toString(),
                    //Constants.productList[widget.productIndex].brandName,
                    style: TextStyle(
                        fontWeight: FontWeight.w900,
                        color: Colors.blueGrey,
                        fontSize: 12),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Icon(Icons.star, color: Colors.yellow),
                  Text(
                    widget.productData.rating.toString(),
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                        fontSize: 10),
                  ),
                ],
              ),
              Text(
                widget.productData.title.toString(),
                style: TextStyle(
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                    fontSize: 14,
                    overflow: TextOverflow.ellipsis),
              ),
              Row(
                children: [
                  SizedBox(
                    width: 3,
                  ),
                  Text(
                    "\$${widget.productData.price}",
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                        fontSize: 14),
                  )
                ],
              ),
            ],
          ),
        ),
        // GestureDetector(
        //   onTap: () {
        //     setState(() {
        //       Constants.productList[widget.productIndex].isFavourite =
        //           !Constants.productList[widget.productIndex].isFavourite;
        //     });
        //   },
        //   child: Padding(
        //     padding: const EdgeInsets.only(left: 140, top: 10),
        //     child: Container(
        //       height: 40,
        //       width: 40,
        //       margin: EdgeInsets.all(7),
        //       decoration: BoxDecoration(
        //         shape: BoxShape.circle,
        //         color: Colors.grey,
        //       ),
        //       child: Icon(
        //           Constants.productList[widget.productIndex].isFavourite
        //               ? Icons.favorite
        //               : Icons.favorite_border_outlined,
        //           color: Colors.white),
        //     ),
        //   ),
        // ),
      ]),
    );
  }
}
