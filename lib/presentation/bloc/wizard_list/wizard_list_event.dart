part of 'wizard_list_bloc.dart';

abstract class WizardListEvent extends Equatable {
  const WizardListEvent();
}

class FetchWizardEvent extends WizardListEvent {
  const FetchWizardEvent();

  @override
  List<Object> get props => [];
}
