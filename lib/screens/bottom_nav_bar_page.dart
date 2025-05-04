import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_ecommerce/screens/category_page.dart';
import 'package:project_ecommerce/screens/favorite_list_page.dart';
import 'package:project_ecommerce/screens/home_page.dart';
import 'package:project_ecommerce/screens/my_cart_page.dart';
import 'package:project_ecommerce/screens/profile_page.dart';

class BottomNavBarPage extends StatefulWidget {
  const BottomNavBarPage({super.key});

  @override
  State<BottomNavBarPage> createState() => _BottomNavBarPageState();
}

class _BottomNavBarPageState extends State<BottomNavBarPage> {
  int pageIndex = 0;

  final pages = [HomePage(), FavoriteList(), CategoryPage(), ProfilePage()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade400,
      body: pages[pageIndex],
      bottomNavigationBar: Container(
        height: 60,
        decoration: BoxDecoration(
          color: Colors.blueGrey,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
                enableFeedback: false,
                onPressed: () {
                  setState(() {
                    pageIndex = 0;
                  });
                },
                icon: pageIndex == 0
                    ? const Icon(
                        Icons.home_filled,
                        color: Colors.white,
                        size: 25,
                      )
                    : Icon(
                        Icons.home_filled,
                        color: Colors.white,
                        size: 25,
                      )),
            IconButton(
                enableFeedback: false,
                onPressed: () {
                  setState(() {
                    pageIndex = 1;
                  });
                },
                icon: pageIndex == 1
                    ? const Icon(
                        Icons.favorite,
                        color: Colors.white,
                        size: 25,
                      )
                    : Icon(
                        Icons.favorite,
                        color: Colors.white,
                        size: 25,
                      )),
            IconButton(
                enableFeedback: false,
                onPressed: () {
                  setState(() {
                    pageIndex = 2;
                  });
                },
                icon: pageIndex == 2
                    ? const Icon(
                        Icons.category,
                        color: Colors.white,
                        size: 25,
                      )
                    : Icon(
                        Icons.category,
                        color: Colors.white,
                        size: 25,
                      )),
            IconButton(
              enableFeedback: false,
              onPressed: () {
                setState(() {
                  pageIndex = 3;
                });
              },
              icon: pageIndex == 3
                  ? const Icon(
                      Icons.person,
                      color: Colors.white,
                      size: 25,
                    )
                  : Icon(
                      Icons.person,
                      color: Colors.white,
                      size: 25,
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
