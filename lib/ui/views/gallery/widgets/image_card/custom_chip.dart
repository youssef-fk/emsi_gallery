import 'dart:typed_data';

import 'package:flutter/material.dart';

class CustomChip extends StatelessWidget {
  final Uint8List imageBytes;
  final String title;
  final Function onTap;

  const CustomChip({
    Key key,
    @required this.imageBytes,
    @required this.title,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 2,
      borderRadius: BorderRadius.circular(90),
      clipBehavior: Clip.antiAlias,
      color: Colors.grey[100],
      child: InkWell(
        onTap: onTap == null ? () => null : onTap,
        child: Container(
          height: 35,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.circular(90),
                clipBehavior: Clip.antiAlias,
                child: Image.memory(imageBytes),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Text(
                  title,
                  style: TextStyle(
                    color: title == ''
                        ? Colors.red.shade900
                        : Colors.grey.shade800,
                    fontWeight: FontWeight.w300,
                    fontSize: 14,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
