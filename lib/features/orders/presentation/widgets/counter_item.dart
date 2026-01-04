
import 'package:flower_app/core/app_extension/app_extension.dart';
import 'package:flutter/material.dart';

class CounterItem extends StatefulWidget {
  const CounterItem({super.key});

  @override
  State<CounterItem> createState() => _CounterItemState();
}

class _CounterItemState extends State<CounterItem> {
  int number = 1;

  @override
  Widget build(BuildContext context) {
     final theme = context.appTheme;
    return Row(
      children: [
        IconButton(
          icon: Icon(Icons.remove, color: theme.surface),
          onPressed: () {
            setState(() {
              if (number > 1) {
                number--;
              }
            });
          },
        ),
        Text("$number", style: theme.semiBold12.copyWith(fontSize: 14)),
        IconButton(
          icon: Icon(Icons.add, color: theme.surface),
          onPressed: () {
            setState(() {
              number++;
            });
          },
        ),
      ],
    );
  }
}
