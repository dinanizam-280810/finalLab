import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:homestay_raya/models/mainmenu.dart';
import 'package:homestay_raya/views/user.dart';

class homePage extends StatefulWidget {
  final User user;
  final Position position;
  const homePage({super.key, required this.user, required this.position});

  @override
  State<homePage> createState() => _homePageState();
}

class _homePageState extends State<homePage> {
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
          appBar: AppBar(title: const Text("Seller")),
          body:  Center(child: Text("Seller")),
          drawer: MainMenuWidget(
            user: widget.user,
            position: widget.position,
          ),
        ));
  }
}
