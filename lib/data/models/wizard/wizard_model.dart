import 'package:equatable/equatable.dart';
import 'package:flutter_wizard/data/models/elixirs/elixirs_model.dart';
import 'package:flutter_wizard/domain/entities/wizard/wizard.dart';

class WizardModel extends Equatable {
  final String id;
  final String? firstName;
  final String? lastName;
  final List<ElixirsModel> elixirs;

  const WizardModel({
    required this.id,
    required this.elixirs,
    this.firstName,
    this.lastName,
  });

  factory WizardModel.fromJson(Map<String, dynamic> json) {
    return WizardModel(
        id: json['id'],
        firstName: json['firstName'] ?? '-',
        lastName: json['lastName'] ?? '-',
        elixirs: List<ElixirsModel>.from(json["elixirs"].map((x) => ElixirsModel.fromJson(x))));
  }

  Wizard toEntity() {
    return Wizard(
      id: id,
      firstName: firstName,
      lastname: lastName,
      elixirs: elixirs.map((elixir) => elixir.toEntity()).toList(),
    );
  }

  @override
  List<Object> get props => [
        id,
        firstName ?? "-",
        lastName ?? "-",
      ];
}
