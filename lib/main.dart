import 'package:Chalet/view/home_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:Chalet/controller/internationalization/internationalization.dart';
import 'package:Chalet/authentication/services/auth.dart';
import 'package:Chalet/wrapper.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(Chalet());
}

//Probabilmente si potrebbero gestire le varie istanze
//del locale con un notifier, invece di aggiornarle manualmente? (@filippo)
class Chalet extends StatefulWidget {
  Chalet({Key? key}) : super(key: key);

  @override
  _ChaletState createState() => _ChaletState();

  static _ChaletState? of(BuildContext context) =>
      context.findAncestorStateOfType<_ChaletState>();

  static void setLocale(BuildContext context, Locale newLocale) async {
    _ChaletState? state = of(context);
    state!.changeLanguage(newLocale);
  }

  static Locale getLocale(BuildContext context) {
    return of(context)!._locale;
  }
}

class _ChaletState extends State<Chalet> {
  Locale _locale = getSupportedLocales().first;

  void changeLanguage(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override
  Widget build(BuildContext context) {
    return StreamProvider.value(
      initialData: null,
      value: AuthService().user,
      child: MaterialApp(
        locale: _locale,
        supportedLocales: getSupportedLocales(),
        localizationsDelegates: getDelegates(),
        localeResolutionCallback: localeResolutionCallback,
        home: const HomePage(),
      ),
    );
  }
}
