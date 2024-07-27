import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:wilcoerp/constants/colors.dart';
import 'package:wilcoerp/pages/splash_page.dart';
import 'package:wilcoerp/providers/app.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  AppProvider appChangeProvider = new AppProvider();
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: CustomColors.primary,
        statusBarIconBrightness: Brightness.light));

    return ChangeNotifierProvider.value(
        value: appChangeProvider,
        child: MaterialApp(
          debugShowCheckedModeBanner: false,

          //initialRoute: "/",
          onGenerateRoute: (settings) {},
          title: 'Wilco ERP',
          theme: ThemeData(
              appBarTheme: Theme.of(context)
                  .appBarTheme
                  .copyWith(brightness: Brightness.dark),
              textTheme: TextTheme(),
              brightness: Brightness.light,
              primaryColor: CustomColors.primary,
              primarySwatch: CustomColors.primary,
              fontFamily: "Montserrat"),
          localizationsDelegates: [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          locale: Locale('es'),
          supportedLocales: [
            const Locale('en'), // English
            const Locale('es'), // Spanish
            const Locale('fr'), // French
            const Locale('zh'), // Chinese
          ],
          home: SplashPage(),
        ));
  }
}
