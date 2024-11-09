import 'package:equatable/equatable.dart';

/// Response model.
class ResponseModel<T> extends Equatable {
  /// Default constructor.
  const ResponseModel({
    required this.isSuccessful,
    required this.message,
    this.result,
  });

  /// Result.
  final T? result;

  /// Is successful.
  final bool isSuccessful;

  /// Message.
  final String message;

  @override
  List<Object?> get props => [result, isSuccessful, message];

  /// to json.
  Map<String, dynamic> toJson() => {
        'result': result,
        'isSuccessful': isSuccessful,
        'message': message,
      };
  
  /// from json.
  factory ResponseModel.fromJson(Map<String, dynamic> json) => ResponseModel(
        result: json['result'] as T,
        isSuccessful: json['isSuccessful'] as bool,
        message: json['message'] as String,
      );
}
