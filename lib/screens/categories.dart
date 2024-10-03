import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/category_bloc.dart';
import '../constants/app_colors.dart';
import '../constants/app_typography.dart';

class Categories extends StatelessWidget {

  final List<String> _categories = [
    "Hot",
    "American",
    "French",
    "Mexico",
    "Malian"
  ];

  @override
  Widget build(BuildContext context) {
    final typography = AppTypography(context);
    return BlocBuilder<CategoriesBloc, CategoriesState>(
      builder: (context, state) {
        return Material(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            child: Row(
              children: _categories.asMap().entries.map((entry) {
                return InkWell(
                  onTap: () {
                    context.read<CategoriesBloc>().add(SelectCategory(entry.key));
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      vertical: typography.padding,
                      horizontal: 2 * typography.padding,
                    ),
                    decoration: BoxDecoration(
                      color: state.selectedIndex == entry.key
                          ? AppColors.SECONDARY_COLOR_DARK
                          : null,
                    ),
                    child: Text(
                      entry.value.toUpperCase(),
                      style: TextStyle(
                        fontSize: typography.h2,
                        color: state.selectedIndex == entry.key
                            ? Colors.white
                            : null,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        );
      },
    );
  }
}
