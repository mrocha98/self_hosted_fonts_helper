import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
class FontFilterItemModel extends Equatable {
  const FontFilterItemModel({
    required this.id,
    required this.family,
    required this.variants,
    required this.subsets,
    required this.category,
    required this.version,
    required this.lastModified,
    required this.popularity,
    required this.defaultSubset,
    required this.defaultVariant,
  });

  factory FontFilterItemModel.fromMap(Map<String, dynamic> map) {
    return FontFilterItemModel(
      id: map['id'] as String,
      family: map['family'] as String,
      variants: List<String>.from(map['variants'] as Iterable),
      subsets: List<String>.from(map['subsets'] as Iterable),
      category: map['category'] as String,
      version: map['version'] as String,
      lastModified: map['lastModified'] as String,
      popularity: map['popularity'] as int,
      defaultSubset: map['defSubset'] as String,
      defaultVariant: map['defVariant'] as String,
    );
  }

  factory FontFilterItemModel.fromJson(String source) =>
      FontFilterItemModel.fromMap(json.decode(source) as Map<String, dynamic>);

  final String id;

  final String family;

  final List<String> variants;

  final List<String> subsets;

  final String category;

  final String version;

  final String lastModified;

  final int popularity;

  final String defaultSubset;

  final String defaultVariant;

  @override
  List<Object?> get props => [
        id,
        family,
        variants,
        subsets,
        category,
        version,
        lastModified,
        popularity,
        defaultSubset,
        defaultVariant,
      ];

  FontFilterItemModel copyWith({
    String? id,
    String? family,
    List<String>? variants,
    List<String>? subsets,
    String? category,
    String? version,
    String? lastModified,
    int? popularity,
    String? defaultSubset,
    String? defaultVariant,
  }) {
    return FontFilterItemModel(
      id: id ?? this.id,
      family: family ?? this.family,
      variants: variants ?? this.variants,
      subsets: subsets ?? this.subsets,
      category: category ?? this.category,
      version: version ?? this.version,
      lastModified: lastModified ?? this.lastModified,
      popularity: popularity ?? this.popularity,
      defaultSubset: defaultSubset ?? this.defaultSubset,
      defaultVariant: defaultVariant ?? this.defaultVariant,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'family': family,
      'variants': variants,
      'subsets': subsets,
      'category': category,
      'version': version,
      'lastModified': lastModified,
      'popularity': popularity,
      'defSubset': defaultSubset,
      'defVariant': defaultVariant,
    };
  }

  String toJson() => json.encode(toMap());
}
