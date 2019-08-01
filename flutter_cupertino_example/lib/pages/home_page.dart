import 'package:flutter/cupertino.dart';
import 'package:flutter_cupertino_example/pages/settings_page.dart';
import 'package:flutter_cupertino_example/pages/user_list_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: CupertinoTabScaffold(
        tabBar: CupertinoTabBar(
          items: [
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.person_solid),
              title: Text('Users'),
            ),
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.settings_solid),
              title: Text('Settings'),
            ),
          ],
        ),
        tabBuilder: (context, index) => CupertinoTabView(
              builder: (context) {
                switch (index) {
                  case 0:
                    return UserListPage();
                  case 1:
                    return SettingsPage();
                  default:
                    return null;
                }
              },
            ),
      ),
    );
  }
}
