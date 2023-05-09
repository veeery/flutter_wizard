import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter_wizard/common/exception.dart';

import '../../common/failure.dart';
import '../../domain/entities/wizard/wizard.dart';
import '../../domain/repositories/wizard_repository.dart';
import '../datasources/wizard/wizard_remote_data_source.dart';

class WizardRepositoryImpl implements WizardRepository {
  final WizardRemoteDataSource remoteDataSource;

  WizardRepositoryImpl({
    required this.remoteDataSource,
  });

  @override
  Future<Either<Failure, List<Wizard>>> getWizard() async {
    try {
      final result = await remoteDataSource.getWizard();
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException {
      return Left(ServerFailure());
    } on SocketException {
      return Left(ConnectionFailure());
    }
  }
}
