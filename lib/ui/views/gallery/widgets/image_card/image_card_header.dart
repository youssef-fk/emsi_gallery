import 'package:flutter/material.dart';

import '../../bloc/gallery_bloc.dart';

enum _PopUpMenuEnum { EDIT, DELETE }

class ImageCardHeader extends StatelessWidget {
  final CustromPoster poster;
  final AppImageData appImageData;

  const ImageCardHeader({
    Key key,
    @required this.poster,
    @required this.appImageData,
  }) : super(key: key);

  void _onSelectMenu(_PopUpMenuEnum selected) {
    switch (selected) {
      case _PopUpMenuEnum.EDIT:
        // TODO: Handle this case.
        break;
      case _PopUpMenuEnum.DELETE:
        // TODO: Handle this case.
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              width: 40,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(45),
                child: Image.network(poster.imageUrl),
              ),
            ),
            SizedBox(width: 14),
            Flexible(
              child: Text(
                poster.poster.name,
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  letterSpacing: 0.2,
                  fontSize: 15,
                ),
              ),
            ),
          ],
        ),
        PopupMenuButton(
          onSelected: _onSelectMenu,
          icon: Icon(
            Icons.more_vert,
            color: Colors.grey.shade800,
            size: 22,
          ),
          itemBuilder: (BuildContext context) {
            return [
              PopupMenuItem(
                child: _renderIconText(
                  'Modifier',
                  Icons.edit,
                  Colors.blueGrey,
                ),
                value: _PopUpMenuEnum.EDIT,
              ),
              PopupMenuItem(
                child: _renderIconText(
                  'Supprimer',
                  Icons.delete,
                  Colors.red,
                ),
                value: _PopUpMenuEnum.DELETE,
              ),
            ];
          },
        ),
      ],
    );
  }
}

Widget _renderIconText(String text, IconData iconData, Color color) => Row(
      children: [
        Icon(
          iconData,
          color: color,
        ),
        SizedBox(width: 6),
        Text(
          text,
          style: TextStyle(color: color),
        ),
      ],
    );
