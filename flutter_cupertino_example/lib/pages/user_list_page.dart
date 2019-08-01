import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter_cupertino_example/entities/user.dart';
import 'package:flutter_cupertino_example/managers/service_manager.dart';
import 'package:flutter_cupertino_example/pages/user_detail_page.dart';

class UserListPage extends StatefulWidget {
  @override
  _UserListPageState createState() => _UserListPageState();
}

class _UserListPageState extends State<UserListPage> {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('Users'),
      ),
      child: FutureBuilder<List<User>>(
        future: _loadUsers(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final userList = snapshot.data;
            return ListView.separated(
              itemCount: userList.length,
              itemBuilder: (context, i) => _buildUserTile(context, userList[i]),
              separatorBuilder: (context, _) => _buildSeparator(context),
            );
          }
          if (snapshot.hasError) {
            return Center(child: Text('Connection Error'));
          }
          // else
          return Center(child: CupertinoActivityIndicator());
        },
      ),
    );
  }

  static Widget _buildUserTile(BuildContext context, User user) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          CupertinoPageRoute(
            builder: (context) => UserDetailPage(user: user),
            title: user.name,
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: <Widget>[
            const Icon(CupertinoIcons.profile_circled, size: 36),
            const SizedBox(width: 12),
            Expanded(
              child: Text(user.name, overflow: TextOverflow.ellipsis),
            ),
          ],
        ),
      ),
    );
  }

  static Widget _buildSeparator(BuildContext context) {
    final isLight = CupertinoTheme.of(context).brightness == Brightness.light;
    return SizedBox(
      height: 1.5,
      child: Container(
        color: isLight
            ? CupertinoColors.lightBackgroundGray
            : CupertinoColors.darkBackgroundGray,
      ),
    );
  }

  static Future<List<User>> _loadUsers() async {
    final service = ServiceManager.instance.userService;
    final userList = await service.getUserList();
    return userList;
  }
}
