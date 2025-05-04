import 'package:flutter/material.dart';

class CategoryStoryWidget extends StatefulWidget {
  final AssetImage image;
  final String name;

  const CategoryStoryWidget({super.key, required this.image, required this.name});

  @override
  State<CategoryStoryWidget> createState() => _CategoryStoryWidgetState();
}

class _CategoryStoryWidgetState extends State<CategoryStoryWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                  colors: [Colors.grey, Colors.blueGrey, Colors.yellow],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight),
            ),
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: CircleAvatar(
                radius: 36,
                // backgroundColor: Colors.black,
                child: Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    CircleAvatar(
                      radius: 34,
                      backgroundImage: widget.image,
                    ),
                  ],
                ),
              ),
            ),
          ),
          Text(
            widget.name,
            style: TextStyle(color: Colors.blueGrey,fontWeight: FontWeight.w800),
          ),
        ],
      ),
    );
  }
}
