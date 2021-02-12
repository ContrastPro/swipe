import 'package:flutter/material.dart';
import 'package:swipe/global/app_colors.dart';

class Filter extends StatefulWidget {
  @override
  _FilterState createState() => _FilterState();
}

class _FilterState extends State<Filter> {
  final List _items = [
    "Вторичный рынок",
    "Новостройки",
    "Все",
    "Коттеджи",
    "Вторичный рынок",
    "Новостройки",
    "Все",
    "Коттеджи",
  ];
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    BoxDecoration active = BoxDecoration(
      gradient: AppColors.buttonGradient,
      borderRadius: BorderRadius.circular(10),
    );

    BoxDecoration inactive = BoxDecoration(
      border: Border.all(
        color: AppColors.accentColor,
      ),
      color: Colors.white,
      borderRadius: BorderRadius.circular(10),
    );
    return Container(
      height: 32,
      margin: const EdgeInsets.symmetric(vertical: 12.0),
      child: ListView.builder(
        itemCount: _items.length,
        scrollDirection: Axis.horizontal,
        physics: BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 2.0),
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              setState(() => _selectedIndex = index);
            },
            child: Container(
              decoration: _selectedIndex == index ? active : inactive,
              margin: const EdgeInsets.symmetric(horizontal: 6.0),
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Center(
                child: Text(
                  '${_items[index]}',
                  style: TextStyle(
                    color: _selectedIndex == index
                        ? Colors.white
                        : AppColors.accentColor,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
