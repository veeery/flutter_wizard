import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/entities/wizard/wizard.dart';
import '../../../domain/usecases/wizard_usecase/get_wizard.dart';

part 'wizard_list_event.dart';

part 'wizard_list_state.dart';

class WizardListBloc extends Bloc<WizardListEvent, WizardListState> {
  final GetWizard getWizard;

  WizardListBloc({required this.getWizard}) : super(WizardListEmpty()) {
    on<FetchWizardEvent>((event, emit) async {
      emit(WizardListLoading());

      final result = await getWizard.execute();

      result.fold(
        (failure) => emit(WizardListError(message: failure.message)),
        (dataWizard) => dataWizard.isEmpty ? emit(WizardListEmpty()) : emit(WizardListLoaded(result: dataWizard)),
      );
    });
  }
}
