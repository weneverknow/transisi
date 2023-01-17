import 'package:equatable/equatable.dart';

class Authentication extends Equatable {
  final String? token;
  const Authentication({this.token});
  @override
  List<Object?> get props => [token];
}
