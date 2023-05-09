import 'package:equatable/equatable.dart';
import 'package:flutter_wizard/data/models/wizard/wizard_model.dart';

class WizardResponse extends Equatable {
  final List<WizardModel> wizardList;

  WizardResponse({required this.wizardList});

  factory WizardResponse.fromJson(Map<String, dynamic> json) {
    return WizardResponse(
      wizardList: List<WizardModel>.from(
        (json['results'] as List).map(
          (e) => WizardModel.fromJson(e),
        ),
      ),
    );
  }

  Map<String, dynamic> toJson() => {
        "results": List<dynamic>.from(wizardList.map((e) => e.toJson())),
      };

  @override
  List<Object?> get props => [wizardList];
}
