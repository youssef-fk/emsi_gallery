import 'package:flutter/material.dart';

class GridItemCard extends StatelessWidget {
  final String text;
  final Function onTap;

  const GridItemCard({
    Key key,
    @required this.text,
    @required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: onTap,
        child: Center(
            child: Text(
          text,
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.w300,
            letterSpacing: 1.5,
            color: Colors.grey.shade800,
          ),
        )),
      ),
    );
  }
}
