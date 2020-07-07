import 'package:flutter/material.dart';

class DrawerRow extends StatelessWidget {
  final String title;
  final Function onTap;

  const DrawerRow({
    Key key,
    @required this.title,
    @required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(Icons.pin_drop),
      title: Text(
        title,
        style: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w400,
        ),
      ),
      onTap: onTap,
    );
  }
}
