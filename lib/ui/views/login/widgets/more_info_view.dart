import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_select/smart_select.dart';

import '../../../../services/auth/models/promo/promo.dart';
import '../../../../services/map/models/city.dart';
import '../../../../services/map/models/site.dart';
import '../bloc/login_bloc.dart';

class MoreInfoView extends StatefulWidget {
  final List<City> cities;

  const MoreInfoView({Key key, @required this.cities})
      : assert(cities != null),
        super(key: key);

  @override
  _MoreInfoViewState createState() => _MoreInfoViewState();
}

class _MoreInfoViewState extends State<MoreInfoView> {
  City selectedCity;
  Site selectedSite;
  PromoField selectedField;
  int selectedYear;

  String get userName => _nameController?.value?.text;
  final _nameController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  void _pickImage() {
    context.bloc<LoginBloc>().add(PickImageEvent());
  }

  void _onPressValidate() {
    if (selectedSite != null && selectedField != null && selectedYear != null && userName != null) {
      context.bloc<LoginBloc>().add(
            SaveUserProfileEvent(
              promoField: selectedField,
              site: selectedSite,
              year: selectedYear,
              userName: userName,
            ),
          );
    } else {
      final title = (context.bloc<LoginBloc>().state as MoreInfo).hasFace
          ? 'Vous avez oublier de remplir tous les champs.'
          : 'Votre photo doit contenir 1 visage';

      AwesomeDialog(
        context: context,
        dialogType: DialogType.WARNING,
        animType: AnimType.BOTTOMSLIDE,
        title: title,
        // desc: 'Dialog description here.............',
        // btnCancelOnPress: () {},
        // btnOkOnPress: () {},
      )..show();

      // showDialog(
      //   context: context,
      //   builder: (_) => AlertDialog(
      //     content: Text(
      //       (context.bloc<LoginBloc>().state as MoreInfo).hasFace
      //           ? 'Vous avez oublier de remplir tous les champs.'
      //           : 'Votre photo doit contenir 1 visage',
      //       textAlign: TextAlign.center,
      //     ),
      //   ),
      // );
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = context.bloc<LoginBloc>().state as MoreInfo;
    final userImage = state.userImage;

    return Container(
      child: Column(
        children: <Widget>[
          ClipPath(
            clipper: _MyClipper(),
            child: Container(
              height: 200,
              alignment: Alignment.center,
              color: Colors.green,
              child: Text(
                'Quelque informations supplementaires',
                textAlign: TextAlign.center,
                style: TextStyle(
                  height: 1.3,
                  fontSize: 24,
                  letterSpacing: 0.5,
                  fontStyle: FontStyle.italic,
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  shadows: [Shadow(blurRadius: 0.7)],
                ),
              ),
            ),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Flexible(
                  flex: 3,
                  child: Container(
                    width: 160,
                    height: 160,
                    alignment: Alignment.center,
                    child: Stack(
                      children: <Widget>[
                        ClipRRect(
                          borderRadius: BorderRadius.circular(90),
                          child: userImage == null
                              ? Icon(
                                  Icons.account_circle,
                                  size: 160,
                                  color: Colors.grey,
                                )
                              : Image.memory(
                                  userImage.readAsBytesSync(),
                                  width: 160,
                                  height: 160,
                                  fit: BoxFit.contain,
                                ),
                        ),
                        Positioned(
                          bottom: 5,
                          right: 5,
                          child: Container(
                            alignment: Alignment.center,
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              color: Colors.green.shade700,
                              borderRadius: BorderRadius.circular(90),
                              border: Border.all(width: 0.6),
                            ),
                            child: IconButton(
                              onPressed: _pickImage,
                              icon: Icon(Icons.photo_camera),
                              iconSize: 24,
                              color: Colors.grey.shade50,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Flexible(
                  flex: 6,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(right: 40, left: 15),
                        child: TextField(
                          controller: _nameController,
                          style: TextStyle(
                            fontSize: 13,
                          ),
                          decoration: InputDecoration(
                            labelText: 'Nom complet',
                            icon: Icon(
                              Icons.person,
                              color:
                                  userName == null ? Colors.grey : Theme.of(context).primaryColor,
                            ),
                          ),
                        ),
                      ),
                      SmartSelect<City>.single(
                        value: selectedCity,
                        title: 'Ville',
                        options: widget.cities
                            .map((city) => SmartSelectOption(value: city, title: city.name))
                            .toList(),
                        onChange: (city) {
                          setState(() {
                            selectedCity = city;
                          });
                        },
                        modalType: SmartSelectModalType.popupDialog,
                        leading: Icon(Icons.location_city),
                        selected: selectedCity != null,
                        dense: true,
                        placeholder: 'Selectionner',
                      ),
                      SmartSelect<Site>.single(
                        value: selectedSite,
                        title: 'Site',
                        options: selectedCity?.sites
                                ?.map((site) => SmartSelectOption(value: site, title: site.name))
                                ?.toList() ??
                            [],
                        onChange: (site) {
                          setState(() {
                            selectedSite = site;
                          });
                        },
                        modalType: SmartSelectModalType.popupDialog,
                        leading: Icon(Icons.location_on),
                        selected: selectedSite != null,
                        dense: true,
                        placeholder: 'Selectionner',
                        enabled: selectedCity != null,
                      ),
                      SmartSelect<PromoField>.single(
                        value: selectedField,
                        title: 'Filliere',
                        options: PromoField.values
                            .map((promo) => SmartSelectOption(value: promo, title: promo.value))
                            .toList(),
                        onChange: (promo) {
                          setState(() {
                            selectedField = promo;
                          });
                        },
                        modalType: SmartSelectModalType.popupDialog,
                        leading: Icon(Icons.school),
                        selected: selectedField != null,
                        dense: true,
                        placeholder: 'Selectionner',
                      ),
                      SmartSelect<int>.single(
                        value: selectedYear,
                        title: 'Annee en cours',
                        options: [1, 2, 3, 4, 5]
                            .map((year) => SmartSelectOption(value: year, title: year.toString()))
                            .toList(),
                        onChange: (year) {
                          setState(() {
                            selectedYear = year;
                          });
                        },
                        modalType: SmartSelectModalType.popupDialog,
                        leading: Icon(Icons.school),
                        selected: selectedYear != null,
                        dense: true,
                        placeholder: 'Selectionner',
                      ),
                    ],
                  ),
                ),
                Flexible(
                  flex: 3,
                  child: SizedBox(
                    height: 45,
                    width: 150,
                    child: OutlineButton.icon(
                      onPressed: _onPressValidate,
                      icon: Icon(
                        Icons.arrow_right,
                        color: Colors.green.shade600,
                      ),
                      label: Text('Poursuivre'),
                      color: Colors.blueGrey.shade100,
                      textColor: Colors.blueGrey.shade700,
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _MyClipper extends CustomClipper<Path> {
  @override
  getClip(Size size) {
    final path = Path();
    path.lineTo(0, size.height - 40);

    final controllPoint = Offset(50, size.height);
    final endPoint = Offset(size.width / 2, size.height);
    path.quadraticBezierTo(controllPoint.dx, controllPoint.dy, endPoint.dx, endPoint.dy);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper oldClipper) {
    return true;
  }
}
