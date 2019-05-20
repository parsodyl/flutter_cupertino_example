import 'package:flutter/cupertino.dart';
import 'package:flutter_cupertino_example/entities/address.dart';
import 'package:flutter_cupertino_example/entities/company.dart';
import 'package:flutter_cupertino_example/entities/user.dart';
import 'package:url_launcher/url_launcher.dart';

class UserDetailPage extends StatefulWidget {
  final User user;

  UserDetailPage({@required this.user}) {
    assert(user != null);
  }

  @override
  _UserDetailPageState createState() => _UserDetailPageState();
}

class _UserDetailPageState extends State<UserDetailPage> {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(),
      child: ListView(
        children: <Widget>[
          _buildCompanyBox(context, widget.user.company),
          _buildUserView(widget.user),
        ],
      ),
    );
  }

  static Widget _buildUserView(User user) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: <Widget>[
          _buildContactRow(CupertinoIcons.mail, user.email.toLowerCase()),
          _buildContactRow(CupertinoIcons.phone, user.phone.toLowerCase()),
          const SizedBox(height: 5),
          _buildAddressButton(user.address),
        ],
      ),
    );
  }

  static Widget _buildAddressButton(Address address) {
    return CupertinoButton.filled(
      padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 4),
      child:
          _buildContactRow(CupertinoIcons.location, _addressSummary(address)),
      onPressed: () async {
        final pos = address.geo;
        final url = "https://www.google.com/maps/@${pos.lat},${pos.lng},4z";
        print(url);
        if (await canLaunch(url)) {
          await launch(url);
        } else {
          throw 'Could not launch $url';
        }
      },
    );
  }

  static Widget _buildCompanyBox(BuildContext context, Company company) {
    final isLight = CupertinoTheme.of(context).brightness == Brightness.light;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
            color: isLight
                ? CupertinoColors.extraLightBackgroundGray
                : CupertinoColors.darkBackgroundGray,
            borderRadius: BorderRadius.all(Radius.circular(12)),
            border: Border.all(
              color: isLight
                  ? CupertinoColors.darkBackgroundGray
                  : CupertinoColors.extraLightBackgroundGray,
            )),
        child: Padding(
          padding:
              const EdgeInsets.only(left: 8, top: 10, right: 8, bottom: 14),
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Text(
                  company.name.toUpperCase(),
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.underline),
                ),
              ),
              Text(
                company.bs.toUpperCase(),
                style: TextStyle(fontSize: 15),
                overflow: TextOverflow.ellipsis,
              ),
              Text(
                "\"${company.catchPhrase}.\"",
                style: TextStyle(fontStyle: FontStyle.italic),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

  static String _addressSummary(Address address) {
    final s = address.street;
    final z = address.zipcode;
    final c = address.city;
    return "$s - $c ($z)";
  }

  static Widget _buildContactRow(IconData iconData, String text) {
    return Row(
      children: <Widget>[
        Icon(iconData, size: 36),
        const SizedBox(width: 8),
        Expanded(
          child: Text(text, overflow: TextOverflow.ellipsis),
        ),
      ],
    );
  }
}
