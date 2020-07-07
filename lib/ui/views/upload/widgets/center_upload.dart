import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/upload_bloc.dart';

class CenterUploadIndicator extends StatelessWidget {
  final Stream<StorageTaskEvent> stream;

  const CenterUploadIndicator({Key key, @required this.stream})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: 0.95,
      child: Material(
        elevation: 4,
        color: Colors.white,
        borderRadius: BorderRadius.circular(4),
        child: Container(
          padding: const EdgeInsets.all(24),
          child: StreamBuilder<StorageTaskEvent>(
            stream: stream,
            builder: (context, builder) {
              final snapshot = builder?.data?.snapshot;
              var value = 0.0;

              if (snapshot != null) {
                value = snapshot.bytesTransferred / snapshot.totalByteCount;
              }

              if (value == 1.0) {
                context.bloc<UploadBloc>().add(
                      UploadFinishedEvent(
                          imagePath: snapshot.storageMetadata.path),
                    );
              }

              return Column(
                children: <Widget>[
                  CircularProgressIndicator(),
                  SizedBox(height: 10),
                  Text(
                      'Upload is at ${(value * 100).toString().split('.')[0]}%'),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
