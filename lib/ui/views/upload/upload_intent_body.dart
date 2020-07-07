import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/upload_bloc.dart';
import 'widgets/profile_search_delegate.dart';

class UploadIntentBody extends StatelessWidget {
  final Loaded state;

  const UploadIntentBody({
    Key key,
    @required this.state,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final _bloc = context.bloc<UploadBloc>();

    return Container(
      width: size.width,
      padding: const EdgeInsets.all(2),
      child: Card(
        clipBehavior: Clip.antiAlias,
        elevation: 1,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            FittedBox(
              alignment: Alignment.topCenter,
              child: SizedBox(
                width: state.image.width.toDouble(),
                height: state.image.height.toDouble(),
                child: CustomPaint(
                  painter: state.facePainter,
                ),
              ),
            ),
            _bloc.title != '' && _bloc.title != null
                ? Column(
                    children: <Widget>[
                      SizedBox(height: 6),
                      Text('Image description'),
                      Divider(height: 14),
                    ],
                  )
                : SizedBox(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14),
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 4, bottom: 4),
                    child: TextField(
                      onChanged: (value) {
                        _bloc.add(SetTitleEvent(title: value));
                      },
                      decoration: InputDecoration(
                        labelText: 'Titre',
                        border: InputBorder.none,
                        icon: Icon(Icons.title),
                      ),
                    ),
                  ),
                  ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: state.faceAndIds.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      final face = state.faceAndIds[index];
                      final faceImage = ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.memory(
                          face.faceData,
                          width: 50,
                          height: 50,
                        ),
                      );

                      return InkWell(
                        onTap: () {
                          final response = showSearch<String>(
                            context: context,
                            delegate: ProfileSearchDelegate(
                              profiles: state.profiles,
                              leading: faceImage,
                            ),
                          );

                          response.then(
                            (value) {
                              print(value);
                              _bloc.add(SetUserNameEvent(name: value, faceAndId: face));
                            },
                          );
                        },
                        child: Row(
                          children: <Widget>[
                            faceImage,
                            SizedBox(width: 20),
                            Text(
                              _bloc.getUserName(face.id) ?? 'Nom de la personne',
                              style: TextStyle(
                                color: Colors.grey.shade800,
                                fontSize: 15,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                  SizedBox(
                    height: 60,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
