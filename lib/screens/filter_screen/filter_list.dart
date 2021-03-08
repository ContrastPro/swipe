import 'package:flutter/material.dart';
import 'package:swipe/global/style/app_colors.dart';

class FilterList extends StatefulWidget {
  @override
  _FilterListState createState() => _FilterListState();
}

class _FilterListState extends State<FilterList> {
  final List _items = [
    "Мои объявления",
    "Все",
    "Вторичный рынок",
    "Новостройки",
    "Коттеджи",
  ];
  int _selectedIndex = 1;

  @override
  Widget build(BuildContext context) {
    BoxDecoration active = BoxDecoration(
      border: Border.all(
        color: Colors.transparent,
      ),
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
