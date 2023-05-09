import 'package:equatable/equatable.dart';
import 'package:flutter_wizard/domain/entities/wizard/wizard.dart';


class WizardModel extends Equatable {
  final String id;
  final String? firstName;
  final String? lastname;

  const WizardModel({
    required this.id,
    this.firstName,
    this.lastname,
  });

  Wizard toEntity() {
    return Wizard(
      id: id,
      firstName: firstName,
      lastname: lastname,
    );
  }

  @override
  List<Object?> get props => [
    id,
    firstName,
    lastname,
  ];
}
