import 'dart:math';

import 'package:emsi_gallery/ui/global/empty_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';

import '../../../global/locator.dart';
import '../../../services/auth/models/promo/promo.dart';
import '../../../services/map/models/site.dart';
import '../../global/loading_widget.dart';
import 'bloc/gallery_bloc.dart';
import 'widgets/custom_fab.dart';
import 'widgets/image_card/image_card.dart';
import 'widgets/profile_menu.dart';

class GalleryArguments {
  final Site site;
  final PromoField promoField;
  final int expectedGraduationYear;

  GalleryArguments({
    @required this.site,
    @required this.promoField,
    @required this.expectedGraduationYear,
  });
}

class GalleryView extends StatelessWidget {
  static const routeName = '/map/gallery';

  final _drawerController = ZoomDrawerController();

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return BlocProvider(
      create: (context) => locator<GalleryBloc>(),
      child: BlocBuilder<GalleryBloc, GalleryState>(
        builder: (context, state) {
          return ZoomDrawer(
            controller: _drawerController,
            mainScreen: GalleryPage(),
            menuScreen: ProfileMenu(),
            angle: 0,
            openCurve: Curves.fastOutSlowIn,
            closeCurve: Curves.easeIn,
            slideWidth: width * (ZoomDrawer.isRTL() ? .45 : 0.70),
          );
        },
      ),
    );
  }
}

class GalleryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final GalleryArguments args = ModalRoute.of(context).settings.arguments;

    final angle = ZoomDrawer.isRTL() ? 180 * pi / 180 : 0.0;
    final width = MediaQuery.of(context).size.width;

    final _bloc = context.bloc<GalleryBloc>();
    final state = _bloc.state;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          '${args.site.name}, ${args.promoField.value}, ${args.expectedGraduationYear}',
        ),
        leading: _bloc.isUsersClass
            ? Transform.rotate(
                angle: angle,
                child: IconButton(
                  icon: Icon(
                    Icons.menu,
                  ),
                  onPressed: () {
                    ZoomDrawer.of(context).toggle();
                  },
                ),
              )
            : null,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.map),
            onPressed: () => _bloc.add(
              NavigateToMapEvent(),
            ),
          ),
          IconButton(
            icon: Icon(Icons.grid_on),
            onPressed: () => _bloc.add(
              OnPressGridEvent(siteName: args.site.name),
            ),
          ),
        ],
      ),
      floatingActionButton: _bloc.isUsersClass ? CustomFAB() : null,
      body: () {
        if (state is GalleryInitial) {
          if (args.expectedGraduationYear == null && args.promoField == null) {
            _bloc.add(OnPressGridEvent(siteName: args.site.name));
          } else {
            _bloc.add(LoadAppImagesEvent(galleryArguments: args));
          }
        }

        if (state is NoDataState) {
          return EmptyViewSvgText(
            svgImagePath: 'assets/images/upload_image.svg',
            message: state.message,
          );
        }

        if (state is Loaded) {
          return AnimatedContainer(
            duration: const Duration(milliseconds: 500),
            child: ListView.builder(
              itemCount: state.appImagesData.length,
              itemBuilder: (context, index) {
                final appImageData = state.appImagesData[index];
                final poster = state.posters.singleWhere(
                  (element) => element.poster.uuid == appImageData.appImage.posterProfileUuid,
                  orElse: () => null,
                );

                return Container(
                  padding: const EdgeInsets.all(0),
                  width: width,
                  child: ImageCard(
                    appImageData: appImageData,
                    poster: poster,
                  ),
                );
              },
            ),
          );
        }

        return LoadingWidget();
      }(),
    );
  }
}
