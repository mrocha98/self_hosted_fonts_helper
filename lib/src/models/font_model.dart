import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import 'font_variant_model.dart';

@immutable
class FontModel extends Equatable {
  const FontModel({
    required this.id,
    required this.family,
    required this.subsets,
    required this.category,
    required this.version,
    required this.lastModified,
    required this.popularity,
    required this.defaultSubset,
    required this.defaultVariant,
    required this.subsetMap,
    required this.storeId,
    required this.variants,
  });

  factory FontModel.fromMap(Map<String, dynamic> map) {
    return FontModel(
      id: map['id'] as String,
      family: map['family'] as String,
      subsets: List.from(map['subsets'] as Iterable, growable: false),
      category: map['category'] as String,
      version: map['version'] as String,
      lastModified: map['lastModified'] as String,
      popularity: map['popularity'] as int,
      defaultSubset: map['defSubset'] as String,
      defaultVariant: map['defVariant'] as String,
      subsetMap: Map.from(map['subsetMap'] as Map),
      storeId: map['storeID'] as String,
      variants: List<dynamic>.from(map['variants'] as Iterable)
          .map((m) => FontVariantModel.fromMap(m as Map<String, dynamic>))
          .toList(growable: false),
    );
  }

  factory FontModel.fromJson(String source) =>
      FontModel.fromMap(json.decode(source) as Map<String, dynamic>);

  final String id;

  final String family;

  final List<String> subsets;

  final String category;

  final String version;

  final String lastModified;

  final int popularity;

  final String defaultSubset;

  final String defaultVariant;

  final Map<String, bool> subsetMap;

  final String storeId;

  final List<FontVariantModel> variants;

  @override
  List<Object?> get props => [
        id,
        family,
        subsets,
        category,
        version,
        lastModified,
        popularity,
        defaultSubset,
        defaultVariant,
        subsetMap,
        storeId,
        variants,
      ];

  FontModel copyWith({
    String? id,
    String? family,
    List<String>? subsets,
    String? category,
    String? version,
    String? lastModified,
    int? popularity,
    String? defaultSubset,
    String? defaultVariant,
    Map<String, bool>? subsetMap,
    String? storeId,
    List<FontVariantModel>? variants,
  }) {
    return FontModel(
      id: id ?? this.id,
      family: family ?? this.family,
      subsets: subsets ?? this.subsets,
      category: category ?? this.category,
      version: version ?? this.version,
      lastModified: lastModified ?? this.lastModified,
      popularity: popularity ?? this.popularity,
      defaultSubset: defaultSubset ?? this.defaultSubset,
      defaultVariant: defaultVariant ?? this.defaultVariant,
      subsetMap: subsetMap ?? this.subsetMap,
      storeId: storeId ?? this.storeId,
      variants: variants ?? this.variants,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'family': family,
      'subsets': subsets,
      'category': category,
      'version': version,
      'lastModified': lastModified,
      'popularity': popularity,
      'defSubset': defaultSubset,
      'defVariant': defaultVariant,
      'subsetMap': subsetMap,
      'storeID': storeId,
      'variants': variants.map((variant) => variant.toMap()),
    };
  }

  String toJson() => json.encode(toMap());
}
