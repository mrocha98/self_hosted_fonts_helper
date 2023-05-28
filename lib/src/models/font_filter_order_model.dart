import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

enum FontFilterOrder {
  ascending,
  descending,
}

enum FontFilterSortBy {
  family,
  category,
  popularity,
  lastModified,
  numberOfStyles,
  numberOfCharsets,
}

@immutable
class FontFilterOrderModel extends Equatable {
  const FontFilterOrderModel({
    required this.sortBy,
    required this.order,
  });

  final FontFilterSortBy sortBy;

  final FontFilterOrder order;

  @override
  List<Object?> get props => [sortBy, order];

  FontFilterOrderModel copyWith({
    FontFilterSortBy? sortBy,
    FontFilterOrder? order,
  }) {
    return FontFilterOrderModel(
      sortBy: sortBy ?? this.sortBy,
      order: order ?? this.order,
    );
  }
}
