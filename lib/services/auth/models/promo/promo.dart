import 'package:json_annotation/json_annotation.dart';

part 'promo.g.dart';

enum PromoField { IIR, IFA, IAII, GI, GC }

extension ParseString on PromoField {
  String get value => this.toString().split('.')[1];
}

@JsonSerializable()
class Promo {
  final int year;
  final int promoFieldIndex;

  Promo(this.year, this.promoFieldIndex);

  PromoField get promoField => PromoField.values[promoFieldIndex];

  factory Promo.fromJson(Map<String, dynamic> json) {
    return _$PromoFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$PromoToJson(this);
  }
}
