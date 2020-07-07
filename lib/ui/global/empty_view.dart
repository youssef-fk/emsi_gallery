import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class EmptyViewSvgText extends StatelessWidget {
  final String message;
  final String svgImagePath;

  const EmptyViewSvgText({
    Key key,
    @required this.message,
    @required this.svgImagePath,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.all(30),
      child: Center(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: SvgPicture.asset(
                this.svgImagePath,
                height: width,
              ),
            ),
            Text(
              this.message,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w300,
                letterSpacing: 1,
              ),
            )
          ],
        ),
      ),
    );
  }
}
