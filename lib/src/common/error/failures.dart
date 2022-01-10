import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  @override
  List<Object> get props => [];

  String get message;
}

// General failures
class ServerFailure extends Failure {
  @override
  String get message => 'Server Failure';
}

class CacheFailure extends Failure {
  @override
  String get message => 'Cache Failure';
}
