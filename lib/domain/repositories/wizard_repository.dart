import 'package:dartz/dartz.dart';

import '../../common/failure.dart';
import '../entities/wizard/wizard.dart';

abstract class WizardRepository {
  // Remote
  Future<Either<Failure, List<Wizard>>> getWizard();
}
