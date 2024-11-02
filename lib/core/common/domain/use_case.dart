import 'package:flow_zero_waste/core/common/domain/response.dart';
import 'package:flow_zero_waste/core/utils/typedef.dart';
import 'package:flutter/foundation.dart';

/// Use case
abstract class UseCase<Type,Params> {
  /// Call method
  ResultFuture<Failure,Type> call(Params params);
}

/// No parameters in use case 
@immutable
class NoParams {
  /// const constructor
  const NoParams();
  
  @override
  bool operator ==(Object other) {
    return other is NoParams;
  }
  
  @override
  int get hashCode =>  runtimeType.hashCode;
}
