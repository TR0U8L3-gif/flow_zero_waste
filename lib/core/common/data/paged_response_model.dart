import 'dart:core';

import 'package:equatable/equatable.dart';

/// Paged response model.
class PagedResponseModel<T> extends Equatable {
  /// Default constructor.
  const PagedResponseModel({
    required this.data,
    required this.pageNumber,
    required this.pageSize,
    required this.totalRecords,
  });

  /// Data.
  final List<T> data;

  /// page number.
  final int pageNumber;

  /// page size.
  final int pageSize;

  /// total records.
  final int totalRecords;

  @override
  List<Object?> get props => [data, pageNumber, pageSize, totalRecords];

  /// to json.
  Map<String, dynamic> toJson() => {
        'data': data,
        'pageNumber': pageNumber,
        'pageSize': pageSize,
        'totalRecords': totalRecords,
      };

  /// from json.
  factory PagedResponseModel.fromJson(Map<String, dynamic> json) =>
      PagedResponseModel(
        data: List<T>.from(json['data'] as List),
        pageNumber: json['pageNumber'] as int,
        pageSize: json['pageSize'] as int,
        totalRecords: json['totalRecords'] as int,
      );
}
