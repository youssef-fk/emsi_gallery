import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../global/locator.dart';
import 'bloc/startup_bloc.dart';

class StartupView extends StatelessWidget {
  static const routeName = '/startup';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => locator<StartupBloc>(),
      child: Scaffold(
        body: Container(
          alignment: Alignment.center,
          child: BlocBuilder<StartupBloc, StartupState>(
            builder: (context, state) {
              context.bloc<StartupBloc>().add(HandleLogin());
              return CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }
}
