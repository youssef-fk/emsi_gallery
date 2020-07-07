import 'package:flutter/material.dart';

import '../../bloc/gallery_bloc.dart';
import 'custom_chip.dart';
import 'image_card_header.dart';

class ImageCard extends StatelessWidget {
  final AppImageData appImageData;
  final CustromPoster poster;

  const ImageCard({Key key, @required this.appImageData, @required this.poster})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Card(
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(
              left: 8,
              top: 2,
              bottom: 2,
            ),
            child: ImageCardHeader(
              poster: poster,
              appImageData: appImageData,
            ),
          ),
          Row(
            children: <Widget>[
              // Text(appImageData.appImage.poster.name)
            ],
          ),
          Image.memory(
            appImageData.image,
            width: width,
          ),
          ...() {
            if (appImageData.appImage.title != '') {
              return [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    appImageData.appImage.title,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      letterSpacing: 1.2,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ),
                Divider(height: 0),
              ];
            } else {
              return [SizedBox()];
            }
          }(),
          Container(
            width: width,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            child: Wrap(
              spacing: 12,
              runSpacing: 12,
              alignment: WrapAlignment.start,
              children: appImageData.faces.map((chip) {
                final index = appImageData.faces.indexOf(chip);
                return CustomChip(
                  title: appImageData.appImage.taggedUsers[index].name,
                  onTap: () => null,
                  imageBytes: chip.faceData,
                );
              }).toList(),
            ),
          )
        ],
      ),
    );
  }
}
