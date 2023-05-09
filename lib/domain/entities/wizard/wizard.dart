import 'package:equatable/equatable.dart';

class Wizard extends Equatable {
  final String id;
  final String? firstName;
  final String? lastname;

  const Wizard({
    required this.id,
    this.firstName,
    this.lastname,
  });

  @override
  List<Object?> get props => [
        id,
        firstName,
        lastname,
      ];
}
