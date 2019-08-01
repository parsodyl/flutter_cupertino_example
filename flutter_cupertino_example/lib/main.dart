import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cupertino_example/pages/home_page.dart';
import 'package:provider/provider.dart';

void main() => runApp(FCEApp());

class FCEApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<Settings>.value(
      value: Settings(),
      child: Consumer<Settings>(
        builder: (context, s, _) {
          return CupertinoApp(
            title: 'FCE App',
            theme: CupertinoThemeData(
              brightness: !s.isDarkMode ? Brightness.light : Brightness.dark,
              primaryColor: s.accentColor,
            ),
            home: HomePage(),
          );
        },
      ),
    );
  }
}

class Settings extends ChangeNotifier {
  var _isDarkMode = false;
  var _accentColor = kYellow;

  bool get isDarkMode => _isDarkMode;
  set isDarkMode(bool value) {
    _isDarkMode = value;
    notifyListeners();
  }

  Color get accentColor => _accentColor;
  set accentColor(Color value) {
    _accentColor = value;
    notifyListeners();
  }
}

const kGreen = Color(0xff239867);
const kCyan = Color(0xff237698);
const kMagenta = Color(0xff982345);
const kYellow = Color(0xff988023);
