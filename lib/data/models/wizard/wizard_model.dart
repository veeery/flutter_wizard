import 'package:equatable/equatable.dart';
import 'package:flutter_wizard/domain/entities/wizard/wizard.dart';

class WizardModel extends Equatable {
  final String id;
  final String? firstName;
  final String? lastName;

  const WizardModel({
    required this.id,
    this.firstName,
    this.lastName,
  });

  factory WizardModel.fromJson(Map<String, dynamic> json) {
    return WizardModel(
      id: json['id'],
      firstName: json['firstName'] ?? '-',
      lastName: json['lastName'] ?? '-',
    );
  }

  Wizard toEntity() {
    return Wizard(
      id: id,
      firstName: firstName,
      lastname: lastName,
    );
  }

  @override
  List<Object> get props => [
        id,
        firstName ?? "-",
        lastName ?? "-",
      ];
}
