import 'package:flutter/material.dart';

class IconWithCount extends StatefulWidget {
  final IconData iconData;
  final int ?initialCount;
  final Color activeColor;
  final Color inactiveColor;
  final String labelText;
  final Function onPressed;

  IconWithCount({
    required this.iconData,
    required this.initialCount,
    this.activeColor = Colors.red,
    this.inactiveColor = Colors.grey,
    required this.labelText,
    required this.onPressed,
  });

  @override
  _IconWithCountState createState() => _IconWithCountState();
}

class _IconWithCountState extends State<IconWithCount> {



  @override
  Widget build(BuildContext context) {
    int? count = widget.initialCount;
    return Row(
      children: [
        IconButton(
          icon: Icon(widget.iconData),
          color: Colors.grey,
          onPressed: () => widget.onPressed(),
        ),
        Text(count.toString()),
        SizedBox(width: 2), // Space between the icon count and text
        Text(widget.labelText),
      ],
    );
  }
}
