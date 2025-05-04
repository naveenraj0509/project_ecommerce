import 'package:flutter/material.dart';
import 'package:project_ecommerce/screens/detail_product_page.dart';
import 'package:project_ecommerce/models/get_all_products_model.dart';
import 'package:project_ecommerce/screens/payment_gateway_page.dart';
import 'package:project_ecommerce/utils/constants.dart';
import 'package:project_ecommerce/widgets/text_field_widget.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

import '../models/get_cart_list_model.dart';
import '../models/get_single_product_model.dart';

class MyCartPage extends StatefulWidget {
  const MyCartPage({
    super.key,
  });

  @override
  State<MyCartPage> createState() => _MyCartPageState();
}

class _MyCartPageState extends State<MyCartPage> {
  late Razorpay razorpay;
  // int? quantity;
  double subTotalPrice = 0;
  double gstPrice = 0;
  double totalPrice = 0;
  // List<int> quantity=[];

  @override
  void initState() {
    super.initState();
    calculateTotalPrice();
    razorpay = Razorpay();
    razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, handlePaymentSuccess);
    razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, handlePaymentError);
    razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, handleExternalWallet);
  }

  void calculateTotalPrice() {
    subTotalPrice = 0;
    for (var index = 0; index < Constants.checkOutList.length; index++) {
      subTotalPrice += Constants.checkOutList[index].price! *
          Constants.checkOutList[index].quantity!;
      gstPrice = (subTotalPrice * 18 / 100);
      totalPrice = subTotalPrice + gstPrice;
    }
  }

  @override
  void dispose() {
    razorpay.clear(); // Clear resources
    super.dispose();
  }

  void openCheckout() async {
    var options = {
      'key': 'rzp_test_waeUUkXGdhnmoe',
      'amount': 100000,
      // (totalPrice * 100).toInt(),
      'currency': "INR",
      'name': 'LifeStyleZ',
      'description': 'Purchase Items',
      'prefill': {
        'contact': '',
        'email': 'test@example.com',
      },
      'external': {
        'wallets': ['paytm'],
      }
    };

    try {
      razorpay.open(options);
    } catch (e) {
      print("Error: $e");
    }
  }

  void handlePaymentSuccess(PaymentSuccessResponse response) {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => PaymentGatewayPage(),
      ),
    );
  }

  void handlePaymentError(PaymentFailureResponse response) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Payment Failed: ${response.message}")),
    );
  }

  void handleExternalWallet(ExternalWalletResponse response) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
          content: Text("External Wallet Selected: ${response.walletName}")),
    );
  }

  Widget build(BuildContext context) {
    print(Constants.checkOutList.length);
    print("checkOutList.length");
    return Scaffold(
      backgroundColor: Colors.grey.shade400,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.grey,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(Icons.arrow_back_outlined),
        ),
        title: Text(
          "My Cart",
          style: TextStyle(fontWeight: FontWeight.w700),
        ),
      ),
      body: (Constants.checkOutList.isEmpty)
          ? Center(
              child: Text(
                "Cart is empty",
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
                      itemCount: Constants.checkOutList.length,
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
                                  image: NetworkImage(Constants
                                          .checkOutList[index].images?[0] ??
                                      ""),
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
                                        text:
                                            '${Constants.checkOutList[index].title}',
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16),
                                      ),
                                    ),
                                    RichText(
                                      text: TextSpan(
                                        text:
                                            "\$${Constants.checkOutList[index].price}",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 22),
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            setState(() {
                                              if (Constants.checkOutList[index]
                                                      .quantity! >
                                                  1) {
                                                Constants.checkOutList[index]
                                                    .quantity = (Constants
                                                        .checkOutList[index]
                                                        .quantity! -
                                                    1);
                                              }
                                              calculateTotalPrice();
                                            });
                                          },
                                          child: Constants.checkOutList[index]
                                                      .quantity! >=
                                                  1
                                              ? const Icon(Icons.remove_circle)
                                              : Container(
                                                  child: Text(''),
                                                ),
                                        ),
                                        Text(Constants
                                            .checkOutList[index].quantity
                                            .toString()),
                                        InkWell(
                                          onTap: () {
                                            setState(() {
                                              if (Constants.checkOutList[index]
                                                          .quantity! >=
                                                      0 &&
                                                  Constants.checkOutList[index]
                                                          .quantity! <
                                                      10) {
                                                Constants.checkOutList[index]
                                                    .quantity = Constants
                                                        .checkOutList[index]
                                                        .quantity! +
                                                    1;
                                              }
                                              calculateTotalPrice();
                                            });
                                          },
                                          child: const Icon(Icons.add_circle),
                                        ),
                                        Spacer(),
                                        GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              Constants.checkOutList.remove(
                                                  Constants
                                                      .checkOutList[index]);
                                              calculateTotalPrice();
                                            });
                                          },
                                          child: Icon(
                                            Icons.delete,
                                            color: Colors.white,
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
                  Container(
                      height: 220,
                      width: double.maxFinite,
                      decoration: BoxDecoration(
                        color: Colors.blueGrey[400],
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(20.0),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Text(
                                    "Subtotal",
                                    style: TextStyle(fontSize: 20),
                                  ),
                                  const Spacer(),
                                  Text("\$${subTotalPrice.toStringAsFixed(2)}"),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Text("GST %"),
                                  Spacer(),
                                  Text("\$${gstPrice.toStringAsFixed(2)}")
                                ],
                              ),
                            ),
                            Divider(
                              indent: 10.0,
                              endIndent: 20.0,
                              thickness: 2,
                              color: Colors.white,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Text(
                                    "Final Amount ",
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  Spacer(),
                                  Text(
                                    "\$${totalPrice.toStringAsFixed(2)}",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  )
                                ],
                              ),
                            ),
                            ElevatedButton(
                              onPressed: () => openCheckout(),
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all(Colors.blueGrey),
                              ),
                              child: const Text(
                                "Place Order",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ))
                ],
              ),
            ),
    );
  }
}
