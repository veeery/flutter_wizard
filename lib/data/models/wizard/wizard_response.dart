import 'package:equatable/equatable.dart';
import 'package:flutter_wizard/data/models/wizard/wizard_model.dart';


class WizardResponse extends Equatable {
  final List<WizardModel> wizardList;

  const WizardResponse({required this.wizardList});

  factory WizardResponse.fromjson(Map<String, dynamic> json) {
    return WizardResponse(
      wizardList: List<WizardModel>.from(
        (json['results'] as List).map(
          (e) => WizardModel.fromJson(e),
        ),
      ),
    );
  }

  // todo toJson here

  @override
  List<Object?> get props => [
        wizardList,
      ];
}
