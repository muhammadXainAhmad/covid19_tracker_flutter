import 'package:covid19_tracker/constants/utils.dart';
import 'package:flutter/material.dart';

class ReusableRow extends StatelessWidget {
  final String title, value;
  const ReusableRow({super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title, style: TextStyle(color: whiteClr)),
              Text(value, style: TextStyle(color: whiteClr)),
            ],
          ),
        ],
      ),
    );
  }
}
