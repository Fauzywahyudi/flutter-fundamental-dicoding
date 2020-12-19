import 'package:flutter/material.dart';

class IconText extends StatelessWidget {
  final String value;
  final IconData icon;
  final Color color;

  const IconText(
      {@required this.value, @required this.icon, @required this.color});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          color: color,
        ),
        SizedBox(width: 5),
        Text(
          value,
          style: Theme.of(context).textTheme.bodyText1,
        ),
      ],
    );
  }
}
