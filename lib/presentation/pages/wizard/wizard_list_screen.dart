import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_wizard/presentation/bloc/wizard_list/wizard_list_bloc.dart';

class WizardListScreen extends StatefulWidget {
  const WizardListScreen({Key? key}) : super(key: key);

  static const routeName = '/wizard-list';

  @override
  State<WizardListScreen> createState() => _WizardListScreenState();
}

class _WizardListScreenState extends State<WizardListScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<WizardListBloc>().add(const FetchWizardEvent());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<WizardListBloc, WizardListState>(
        builder: (context, state) {
          if (state is WizardListLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is WizardListLoaded) {
            return ListView.builder(
              itemCount: state.result.length,
              itemBuilder: (context, index) {
                final wizard = state.result[index];

                return Text(wizard.firstName ?? "-");
              },
            );
          } else if (state is WizardListError) {
            return Center(
              key: const Key('error_message'),
              child: Text(state.message),
            );
          } else {
            return const Center(child: Text('Empty Data'));
          }
        },
      ),
    );
  }
}
