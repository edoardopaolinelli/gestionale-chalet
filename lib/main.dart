import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:fluttertest/home.dart';
import 'package:fluttertest/sezione_bar.dart';
import 'package:fluttertest/sezione_lettini.dart';
import 'package:fluttertest/sezione_ombrelloni.dart';
import 'package:fluttertest/sezione_eventi.dart';
import 'package:fluttertest/sign_in.dart';
import 'package:fluttertest/list_item_handler.dart';
import 'package:fluttertest/widgets_builder.dart';
import 'package:fluttertest/cart_handler.dart';

void main() => runApp(MaterialApp(
      home: CasottoHome(),
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en'),
        Locale('it', 'IT'),
      ],
      locale: const Locale('it', 'IT'),
    ));

class CasottoHome extends StatefulWidget {
  @override
  _CasottoState createState() => _CasottoState();
}

class _CasottoState extends State<CasottoHome> {
  final _pageController = PageController(initialPage: 0);
  final _cartKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          leading: IconButton(
            icon: Icon(Icons.portrait_outlined),
            onPressed: () {
              Navigator.of(context).push(createRoute(SignInDemo()));
            },
          ),
          actions: const <Widget>[Icon(Icons.more_vert_outlined)],
          centerTitle: true,
          title: createText('CASOTTO', TextAlign.center, FontWeight.bold, 1.4,
              24, Colors.white)),
      body: PageView(
        physics: const AlwaysScrollableScrollPhysics(),
        scrollDirection: Axis.vertical,
        controller: _pageController,
        padEnds: false,
        children: <Widget>[
          createHomeScreen(context, _pageController), //1st page
          createSezioneOmbrelloni(context, _pageController, //2nd page
              (int index, bool isExpanded) {
            setState(() {
              List<OmbrelloniItem> _ombrelloni = getOmbrelloni();
              _ombrelloni[index].isExpanded = !_ombrelloni[index].isExpanded;
            });
          }),
          createSezioneLettini(context, _pageController,
              (int index, bool isExpanded) {
            setState(() {
              List<LettiniItem> _lettini = getLettini();
              _lettini[index].isExpanded = !_lettini[index].isExpanded;
            });
          }), //3rd page
          createSezioneBar(context, _pageController), //4th page
          createSezioneEventi(context, _pageController) //5th page
        ],
      ),
      floatingActionButton: FloatingActionButton(
          elevation: 1,
          onPressed: () {
            showDialog(
                context: context, builder: (context) => CartPopup(_cartKey));
          },
          child: const Icon(Icons.shopping_cart_outlined),
          backgroundColor: Colors.transparent,
          mini: false,
          shape: CircleBorder(side: BorderSide(color: Colors.white))),
    );
  }
}
