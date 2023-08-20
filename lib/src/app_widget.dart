import 'package:app_hospital/src/core/themes/themes.dart';
import 'package:app_hospital/src/modules/speech_to_text/presenter/cubits/speech_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => SpeechCubit(),
        ),
      ],
      child: MaterialApp.router(
          debugShowCheckedModeBanner: false,
          title: 'My Smart App',
          themeMode: ThemeMode.light,
          theme: lightTheme,
          darkTheme: darkTheme,
          routerDelegate: Modular.routerDelegate,
          routeInformationParser: Modular.routeInformationParser,
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale('pt', 'BR'),
          ]),
    );
  }
}
