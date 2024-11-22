import 'package:fpdart/fpdart.dart';


/// future of either failure or success
typedef ResultFuture<Failure, Success> = Future<Either<Failure, Success>>;

/// map of string and dynamic
typedef DataMap = Map<String, dynamic>;
