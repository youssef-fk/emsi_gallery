import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../global/locator.dart';
import 'bloc/login_bloc.dart';
import 'widgets/login_bar.dart';
import 'widgets/more_info_view.dart';

class LoginView extends StatelessWidget {
  static const routeName = '/login';

  @override
  Widget build(BuildContext context) {
    return LoginViewStateful();
  }
}

class LoginViewStateful extends StatefulWidget {
  static const errorSnackBar = SnackBar(
    content: Text('There was an error signing in.'),
    duration: Duration(seconds: 6),
    backgroundColor: Colors.red,
  );

  @override
  _LoginViewStatefulState createState() => _LoginViewStatefulState();
}

class _LoginViewStatefulState extends State<LoginViewStateful> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width * 0.8;

    return BlocProvider(
      create: (context) => locator<LoginBloc>(),
      child: Scaffold(
        resizeToAvoidBottomPadding: false,
        body: BlocConsumer<LoginBloc, LoginState>(
          listener: (context, state) {
            if (state is LoginError) {
              Scaffold.of(context)
                  .showSnackBar(LoginViewStateful.errorSnackBar);
            }
          },
          builder: (context, state) {
            final firstChild = Container(
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(top: 30, bottom: 30),
                        child: Text(
                          'Emsi Photo Book',
                          style: TextStyle(
                            fontSize: 36,
                            fontFamily: 'Satisfy',
                            color: Colors.blueGrey.shade700,
                          ),
                        ),
                      ),
                      SvgPicture.asset(
                        'assets/images/moments.svg',
                        height: width,
                      ),
                    ],
                  ),
                  Column(
                    children: <Widget>[
                      _facebookBar(() => null),
                      SizedBox(
                        height: 12,
                      ),
                      _googleBar(() {
                        context.bloc<LoginBloc>().add(LoginWithGoogleEvent());
                      }),
                    ],
                  ),
                ],
              ),
            );

            if (state is Loading) {
              return Container(
                width: width,
                child: LinearProgressIndicator(),
              );
            }

            return AnimatedCrossFade(
              firstChild: firstChild,
              secondChild: state is MoreInfo
                  ? MoreInfoView(
                      cities: state.cities,
                    )
                  : SizedBox(),
              crossFadeState: state is MoreInfo
                  ? CrossFadeState.showSecond
                  : CrossFadeState.showFirst,
              duration: Duration(seconds: 1),
            );
          },
        ),
      ),
    );
  }
}

_googleBar(Function onPress) => LoginBar(
      logo: 'google_logo.png',
      text: 'Continuer avec Google',
      onPress: onPress,
    );

_facebookBar(Function onPress) => LoginBar(
      logo: 'facebook_logo.png',
      text: 'Continuer avec Facebook',
      onPress: onPress,
    );
