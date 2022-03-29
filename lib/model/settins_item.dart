import 'package:flutter/material.dart';
import 'package:todoapp/constants/color_constant.dart';

class SettingsItem extends StatefulWidget {
  SettingsItem({
    required this.secondWidget,
    required this.text,
  });
  Widget secondWidget;
  Text text;

  @override
  State<SettingsItem> createState() => _SettingsItemState();
}

class _SettingsItemState extends State<SettingsItem> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [widget.text, widget.secondWidget],
        ),
        Divider(
          thickness: .5,
        )
      ],
    );
  }
}
