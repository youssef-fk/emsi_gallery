import 'package:emsi_gallery/ui/views/gallery/bloc/gallery_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileMenu extends StatelessWidget {
  static const _kImageSize = 145.0;
  static const _kTextColor = Colors.white;
  static const _kTextStyle = TextStyle(
    fontSize: 17,
    fontWeight: FontWeight.w300,
    letterSpacing: 1,
    color: _kTextColor,
  );

  @override
  Widget build(BuildContext context) {
    final _bloc = context.bloc<GalleryBloc>();
    final _size = MediaQuery.of(context).size;

    final _children = <Widget>[
      Center(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(90),
          child: Image.network(
            _bloc.userProfileImageUrl,
            width: _kImageSize,
            height: _kImageSize,
          ),
        ),
      ),
      ListTile(
        contentPadding: const EdgeInsets.only(top: 25),
        leading: Icon(Icons.account_box, color: Colors.white),
        title: Text(
          _bloc.userProfile.name,
          style: _kTextStyle,
          overflow: TextOverflow.fade,
          maxLines: 2,
        ),
      ),
      ListTile(
        contentPadding: const EdgeInsets.all(0),
        leading: Icon(Icons.pin_drop, color: Colors.white),
        title: Text(
          'Emsi ${_bloc.userProfile.site.name}',
          style: _kTextStyle,
        ),
      ),
      ListTile(
        contentPadding: const EdgeInsets.all(0),
        leading: Icon(Icons.school, color: Colors.white),
        title: Text(
          '${_bloc.userProfile.promo.year} ${_bloc.userProfile.promoName}',
          style: _kTextStyle,
        ),
      ),
      ListTile(
        onTap: () {},
        contentPadding: const EdgeInsets.all(0),
        leading: Icon(Icons.edit, color: Colors.white),
        title: Text(
          'Modifier',
          style: _kTextStyle,
        ),
      ),
      ListTile(
        onTap: () {},
        contentPadding: const EdgeInsets.all(0),
        leading: Icon(Icons.info, color: Colors.white),
        title: Text(
          'A propos',
          style: _kTextStyle,
        ),
      ),
    ];

    return Scaffold(
      backgroundColor: Colors.blueGrey.shade800,
      body: Container(
        width: _size.width * .70,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        margin: EdgeInsets.only(top: _size.height * .1),
        child: SafeArea(
          child: ListView.separated(
            separatorBuilder: (context, index) => SizedBox(height: 15),
            itemCount: _children.length,
            itemBuilder: (context, index) => _children.elementAt(index),
          ),
        ),
      ),
    );
  }
}
