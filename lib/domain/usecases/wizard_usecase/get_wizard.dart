import 'package:dartz/dartz.dart';
import 'package:flutter_wizard/domain/entities/wizard/wizard.dart';
import 'package:flutter_wizard/domain/repositories/wizard_repository.dart';

import '../../../common/failure.dart';

class GetWizard {
  final WizardRepository repository;

  GetWizard({required this.repository});

  Future<Either<Failure, List<Wizard>>> execute() {
    return repository.getWizard();
  }
}
