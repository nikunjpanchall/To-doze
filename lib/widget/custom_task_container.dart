import 'package:flutter/material.dart';
import 'package:todo/utils/app_theme.dart';

class CustomTaskContainer extends StatelessWidget {
  CustomTaskContainer({
    required this.num,
    required this.title,
    super.key,
  });

  String num;
  String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width / 2.3,
      height: 100,
      decoration: BoxDecoration(
        border: Border.all(
          width: 2,
          color: Colors.black54,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            num.toString(),
            style: AppTheme.bodyText,
          ),
          Text(
            title,
            style: AppTheme.bodyText,
          )
        ],
      ),
    );
  }
}
