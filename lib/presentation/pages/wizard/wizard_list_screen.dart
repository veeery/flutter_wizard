import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_wizard/common/app_color.dart';
import 'package:flutter_wizard/common/responsive.dart';
import 'package:flutter_wizard/data/models/elixirs/elixirs_model.dart';
import 'package:flutter_wizard/presentation/bloc/wizard_list/wizard_list_bloc.dart';
import 'package:flutter_wizard/presentation/widgets/app_button.dart';
import 'package:flutter_wizard/presentation/widgets/app_loadmore.dart';
import 'package:flutter_wizard/presentation/widgets/custom_expansion_tile.dart';

import '../../../common/app_curve_size.dart';
import '../../widgets/app_loading.dart';

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
            return AppLoading();
          } else if (state is WizardListLoaded) {
            return AppLoadMore(
              isLastPage: true,
              noMoreText: '',
              onLoadmore: () => context.read().add(FetchWizardEvent()),
              // onRefresh: () async {
              //   context.read<WizardListBloc>().add(const FetchWizardEvent());
              // },
              child: ListView.builder(
                itemCount: state.result.length,
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  final wizard = state.result[index];

                  return Card(
                    margin: EdgeInsets.symmetric(vertical: 1.h, horizontal: 1.h),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(CurveSize.smallCurve)),
                    color: AppColor.kMikadoYellow,
                    child: Container(
                      width: 100.w,
                      padding: EdgeInsets.symmetric(vertical: 1.h, horizontal: 1.h),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('First Name : ${wizard.firstName}'),
                          Text('Last Name : ${wizard.lastname}'),
                          SizedBox(height: 2.h),
                          CustomExpansionTile(
                            title: Text('Elixirs (have ${wizard.elixirs.length})'),
                            children: [
                              ListView.builder(
                                shrinkWrap: true,
                                itemCount: wizard.elixirs.length,
                                itemBuilder: (context, index) {
                                  ElixirsModel elixir = wizard.elixirs[index];

                                  return Text('${index + 1} ${elixir.name}');
                                },
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
            );
          } else if (state is WizardListError) {
            return Center(
              key: const Key('error_message'),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(state.message),
                  SizedBox(height: 2.h),
                  SizedBox(
                    height: 4.h,
                    width: 25.w,
                    child: AppButton(
                      title: 'Refresh',
                      onTap: () {
                        context.read<WizardListBloc>().add(const FetchWizardEvent());
                      },
                    ),
                  )
                ],
              ),
            );
          } else {
            return const Center(child: Text('Empty Data'));
          }
        },
      ),
    );
  }
}
