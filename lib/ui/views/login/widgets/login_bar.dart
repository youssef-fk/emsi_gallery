import 'package:flutter/material.dart';

class LoginBar extends StatelessWidget {
  final String logo;
  final String text;
  final Function onPress;

  const LoginBar({
    Key key,
    @required this.logo,
    @required this.text,
    @required this.onPress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.8,
      child: OutlineButton(
        onPressed: onPress,
        splashColor: Colors.grey,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6),
        ),
        highlightElevation: 0,
        borderSide: BorderSide(color: Colors.grey),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Image.asset(
                'assets/images/$logo',
                height: 35,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Text(
                    text,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
