import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../global/locator.dart';
import '../../global/empty_view.dart';
import 'bloc/grid_gallery_bloc.dart';
import 'widgets/grid_item_card.dart';

class GridGalleryViewArgs {
  final String siteName;

  GridGalleryViewArgs({@required this.siteName});
}

class GridGalleryView extends StatelessWidget {
  static const routeName = 'grid_gallery_view';

  @override
  Widget build(BuildContext context) {
    final GridGalleryViewArgs args = ModalRoute.of(context).settings.arguments;
    final siteName = args.siteName;

    return BlocProvider(
      create: (context) => locator<GridGalleryBloc>(),
      child: BlocBuilder<GridGalleryBloc, GridGalleryState>(
        builder: (context, state) {
          final _bloc = BlocProvider.of<GridGalleryBloc>(context);
          Widget body, leading;

          if (state is GridGalleryInitial) {
            _bloc.add(
              LoadGridGalleryEvent(siteName: siteName),
            );
          }

          if (state is GridGalleryLoaded) {
            body = _renderGridView(state.majorYearsList
                .map((e) => GridItemCard(
                      text: e.majorName,
                      onTap: () => _bloc.add(
                        MajorYearsGridGalleryEvent(majorYears: e),
                      ),
                    ))
                .toList());
          }

          if (state is GridGalleryMajorYears) {
            body = _renderGridView(state.majorYears.years
                .map((e) => GridItemCard(
                      text: e.toString(),
                      onTap: () => _bloc.add(NavigateToGalleryEvent(
                        year: e,
                        majorName: state.majorYears.majorName,
                      )),
                    ))
                .toList());

            leading = IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () => _bloc.add(GoBackFromYearsEvent()),
            );
          }

          if (state is EmptyGridGalleryState) {
            body = EmptyViewSvgText(
              svgImagePath: 'assets/images/empty.svg',
              message: state.message,
            );
          }

          return Scaffold(
            appBar: AppBar(
              title: Text('Filliere'),
              leading: leading,
            ),
            body: body,
          );
        },
      ),
    );
  }
}

Widget _renderGridView(List<Widget> children) => GridView.count(
      padding: const EdgeInsets.all(12),
      crossAxisSpacing: 6,
      mainAxisSpacing: 6,
      crossAxisCount: 2,
      children: children,
    );
