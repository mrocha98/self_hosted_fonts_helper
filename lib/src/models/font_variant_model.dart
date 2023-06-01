import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
class FontVariantModel extends Equatable {
  const FontVariantModel({
    required this.id,
    required this.fontFamily,
    required this.fontStyle,
    required this.fontWeight,
    required this.woff,
    required this.woff2,
    required this.eot,
    required this.svg,
    required this.ttf,
  });

  factory FontVariantModel.fromMap(Map<String, dynamic> map) {
    return FontVariantModel(
      id: map['id'] as String,
      fontFamily: map['fontFamily'] as String,
      fontStyle: map['fontStyle'] as String,
      fontWeight: map['fontWeight'] as String,
      woff: map['woff'] as String,
      woff2: map['woff2'] as String,
      eot: map['eot'] as String,
      svg: map['svg'] as String,
      ttf: map['ttf'] as String,
    );
  }

  factory FontVariantModel.fromJson(String source) =>
      FontVariantModel.fromMap(json.decode(source) as Map<String, dynamic>);

  final String id;

  final String fontFamily;

  final String fontStyle;

  final String fontWeight;

  final String woff;

  final String woff2;

  final String eot;

  final String svg;

  final String ttf;

  @override
  List<Object?> get props => [
        id,
        fontFamily,
        fontStyle,
        fontWeight,
        woff,
        woff2,
        eot,
        svg,
        ttf,
      ];

  FontVariantModel copyWith({
    String? id,
    String? fontFamily,
    String? fontStyle,
    String? fontWeight,
    String? woff,
    String? woff2,
    String? eot,
    String? svg,
    String? ttf,
  }) {
    return FontVariantModel(
      id: id ?? this.id,
      fontFamily: fontFamily ?? this.fontFamily,
      fontStyle: fontStyle ?? this.fontStyle,
      fontWeight: fontWeight ?? this.fontWeight,
      woff: woff ?? this.woff,
      woff2: woff2 ?? this.woff2,
      eot: eot ?? this.eot,
      svg: svg ?? this.svg,
      ttf: ttf ?? this.ttf,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'fontFamily': fontFamily,
      'fontStyle': fontStyle,
      'fontWeight': fontWeight,
      'woff': woff,
      'woff2': woff2,
      'eot': eot,
      'svg': svg,
      'ttf': ttf,
    };
  }

  String toJson() => json.encode(toMap());
}
