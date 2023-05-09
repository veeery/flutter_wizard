import 'package:flutter_wizard/data/datasources/wizard/wizard_remote_data_source.dart';
import 'package:flutter_wizard/data/repositories/wizard_repository_impl.dart';
import 'package:flutter_wizard/domain/repositories/wizard_repository.dart';
import 'package:flutter_wizard/domain/usecases/wizard_usecase/get_wizard.dart';
import 'package:flutter_wizard/presentation/bloc/wizard_list/wizard_list_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

final locator = GetIt.instance;

void init() {
  // BLoC
  locator.registerFactory(() => WizardListBloc(getWizard: locator()));

  // Use case
  locator.registerLazySingleton(() => GetWizard(repository: locator()));

  // Repository
  locator.registerLazySingleton<WizardRepository>(
    () => WizardRepositoryImpl(
      remoteDataSource: locator(),
    ),
  );

  // Data Source
  locator.registerLazySingleton<WizardRemoteDataSource>(() => WizardRemoteDataSourceImpl(client: locator()));

  // external
  locator.registerLazySingleton(() => http.Client());
}
