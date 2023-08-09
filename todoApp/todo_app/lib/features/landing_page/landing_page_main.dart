import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:todo_app/features/login_page/presentation/login_screen_widget.dart';

class LandingPageMain extends StatefulWidget {
  const LandingPageMain({Key? key}) : super(key: key);

  @override
  State<LandingPageMain> createState() => _LandingPageMainState();
}

class _LandingPageMainState extends State<LandingPageMain> {
  @override
  Widget build(BuildContext context) {
    return LoginScreenMain();
  }
}
