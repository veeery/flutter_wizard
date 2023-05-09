import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_wizard/common/app_overlay.dart';
import 'package:flutter_wizard/common/responsive.dart';
import 'package:flutter_wizard/presentation/bloc/wizard_list/wizard_list_bloc.dart';
import 'package:flutter_wizard/presentation/pages/wizard/wizard_list_screen.dart';
import 'injection.dart' as di;

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
      value: AppOverlay.mySystemTheme,
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (_) => di.locator<WizardListBloc>(),
          ),
        ],
        child: MaterialApp(
          builder: (context, child) {
            AppResponsive.init(context: context);
            return MediaQuery(
              data: MediaQuery.of(context).copyWith(textScaleFactor: 1),
              child: child!,
            );
          },
          title: 'Flutter Wizard',
          home: const WizardListScreen(),
          onGenerateRoute: (settings) {
            switch (settings.name) {
              case WizardListScreen.routeName:
                return MaterialPageRoute(builder: (_) => const WizardListScreen());
              default:
                return MaterialPageRoute(builder: (_) {
                  return const Scaffold(
                    body: Center(
                      child: Text('Page not found :('),
                    ),
                  );
                });
            }
          },
        ),
      ),
    );
  }
}
