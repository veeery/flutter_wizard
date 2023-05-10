import 'package:equatable/equatable.dart';
import 'package:flutter_wizard/data/models/elixirs/elixirs_model.dart';

class Wizard extends Equatable {
  final String id;
  final String? firstName;
  final String? lastname;
  final List<ElixirsModel> elixirs;

  const Wizard({
    required this.id,
    required this.elixirs,
    this.firstName,
    this.lastname,
  });

  @override
  List<Object?> get props => [
        id,
        firstName,
        lastname,
        elixirs,
      ];
}
