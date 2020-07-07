import 'package:flutter/material.dart';

import '../../gallery/bloc/gallery_bloc.dart';

class ProfileSearchDelegate extends SearchDelegate<String> {
  final List<CustromPoster> profiles;
  final Widget leading;
  final String searchFieldLabel = 'Saisir ou selectionner';

  ProfileSearchDelegate({
    @required this.profiles,
    @required this.leading,
  });

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      query.length != 0
          ? IconButton(
              icon: Icon(Icons.clear),
              onPressed: () => this.query = '',
            )
          : Container(),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(6),
      width: 50,
      height: 50,
      child: this.leading,
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return _onQueryChange(context);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return _onQueryChange(context);
  }

  Widget _onQueryChange(BuildContext context) {
    final buildProfiles = profiles
        .where(
          (element) => element.poster.name.contains(this.query),
        )
        .toList();

    return ListView(
      padding: const EdgeInsets.all(10),
      itemExtent: 60,
      children: buildProfiles
          .map(
            (profile) => _buildItem(
              () {
                this.close(context, profile.poster.name);
              },
              ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: Image.network(
                  profile.imageUrl,
                  width: 50,
                  height: 50,
                ),
              ),
              profile.poster.name,
            ),
          )
          .toList()
            ..insert(
              0,
              _buildItem(
                () => this.close(context, this.query),
                Icon(Icons.account_circle, size: 50),
                query,
              ),
            ),
    );
  }

  ListTile _buildItem(Function onTap, Widget leading, String title) => ListTile(
        onTap: onTap,
        leading: leading,
        title: Text(title),
      );
}
