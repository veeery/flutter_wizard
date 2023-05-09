part of 'wizard_list_bloc.dart';

abstract class WizardListState extends Equatable {
  @override
  List<Object> get props => [];
}

class WizardListEmpty extends WizardListState {}

class WizardListLoading extends WizardListState {}

class WizardListLoaded extends WizardListState {
  final List<Wizard> result;

  WizardListLoaded({required this.result});

  @override
  List<Object> get props => [result];
}

class WizardListError extends WizardListState {
  final String message;

  WizardListError({required this.message});

  @override
  List<Object> get props => [message];
}
