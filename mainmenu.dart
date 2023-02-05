import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:homestay_raya/models/hometab.dart';
import 'package:homestay_raya/models/profiletab.dart';
import 'package:homestay_raya/views/user.dart';

class MainMenuWidget extends StatefulWidget {
  final User user;
  final Position position;
  const MainMenuWidget({super.key, required this.user, required this.position});

  @override
  State<MainMenuWidget> createState() => _MainMenuWidgetState();
}

class _MainMenuWidgetState extends State<MainMenuWidget> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
        width: 250,
        elevation: 10,
        child: ListView(
          children: [
            UserAccountsDrawerHeader(
              accountEmail: Text(widget.user.email.toString()),
              accountName: Text(widget.user.name.toString()),
              currentAccountPicture: const CircleAvatar(
                radius: 30.0,
              ),
            ),
            ListTile(
              title: const Text('Seller'),
              onTap: () {
                Navigator.pop(
                    context,
                    MaterialPageRoute(
                        builder: (content) =>
                            homeTab(user: widget.user, position: widget.position)));
              },
            ),
           
            ListTile(
              title: const Text('Profile'),
              onTap: () {
                Navigator.pop(
                    context,
                    MaterialPageRoute(
                        builder: (content) => profileTab(
                              user: widget.user,
                            )));
              },
            ),
          ],
        ));
  }
}
