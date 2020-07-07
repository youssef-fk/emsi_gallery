import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../global/locator.dart';
import 'bloc/upload_bloc.dart';
import 'upload_intent_body.dart';
import 'widgets/center_upload.dart';

class UploadIntentViewArgs {
  final File image;

  UploadIntentViewArgs({@required this.image});
}

class UploadIntentView extends StatelessWidget {
  static const routeName = 'upload_intent_view';

  @override
  Widget build(BuildContext context) {
    final UploadIntentViewArgs args = ModalRoute.of(context).settings.arguments;

    return BlocProvider(
      create: (context) => locator<UploadBloc>(),
      child: BlocConsumer<UploadBloc, UploadState>(
        listener: (context, state) {
          if (state is Aborted) Navigator.pop(context);
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: Text('Uploading ...'),
              automaticallyImplyLeading: false,
              actions: <Widget>[
                IconButton(
                  icon: Icon(Icons.cancel),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                )
              ],
            ),
            floatingActionButton: FloatingActionButton.extended(
              label: Text(
                'Poster',
                style: TextStyle(color: Colors.white),
              ),
              icon: Icon(Icons.keyboard_arrow_right, color: Colors.white),
              onPressed: () {
                context.bloc<UploadBloc>().add(UploadImageEvent());
              },
            ),
            body: () {
              if (state is Loading || state is UploadInitial) {
                if (state is UploadInitial)
                  context.bloc<UploadBloc>().add(PrepareImageEvent(imageFile: args.image));

                return Container(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              }
              if (state is Loaded)
                return SingleChildScrollView(
                  physics: AlwaysScrollableScrollPhysics(),
                  child: Stack(
                    alignment: Alignment.center,
                    children: <Widget>[
                      UploadIntentBody(
                        state: state,
                      ),
                      state is UploadingImage
                          ? Positioned(
                              child: CenterUploadIndicator(
                                stream: state.uploadStream,
                              ),
                            )
                          : SizedBox(),
                    ],
                  ),
                );

              return Container();
            }(),
          );
        },
      ),
    );
  }
}
