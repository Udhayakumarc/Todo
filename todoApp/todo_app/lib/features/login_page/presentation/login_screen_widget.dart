import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_app/core/app_theme/theme_generator.dart';
import 'package:todo_app/core/cache_images/cache_image_builder.dart';
import 'package:todo_app/core/common_const/const_asset_image.dart';
import 'package:todo_app/core/locale/local_constant.dart';
import 'package:todo_app/features/login_page/presentation/login_container.dart';

class LoginScreenMain extends StatefulWidget {
  const LoginScreenMain({Key? key}) : super(key: key);

  @override
  State<LoginScreenMain> createState() => _LoginScreenMainState();
}

class _LoginScreenMainState extends State<LoginScreenMain> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () {
        //close application
        SystemNavigator.pop();
        return Future.value(true);
      },
      child: Scaffold(
        body: GestureDetector(
          /// tap anywhere on screen will close keyboard if open
          key: const Key('loginScreenKey1'),
          onTap: () {
            FocusScope.of(context).requestFocus(FocusNode());
          },
          child: Stack(
            children: [
              SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: getHeights(size),
                      width: size.width,
                      child: Stack(
                        children: [
                          BackGroundImage(),
                          //WelcomeText(size: size),
                          LoginContainer(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  ///  based on device height this function will change widget height
  ///  changed value for fixing MA-2678
  double getHeights(Size size) {
    // if (size.height >= 900) {
    //   return 710;
    // }
    // if (size.height >= 770 && size.height < 900) {
    //   return 690;
    // }
    // if (size.height > 700 && size.height < 770) {
    //   return 640;
    // }
    // if (size.height <= 700) {
    //   return 620;
    // }
    return 845;
  }
}

class WelcomeText extends StatelessWidget {
  const WelcomeText({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return AnimatedPositioned(
      duration: const Duration(milliseconds: 350),
      top: (size.height > 800 ? 65.h : 50.h),
      left: 34.h,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 10.h,
          ),
          SizedBox(
            width: size.width * 0.66,
            child: Text(
              LocalStrings.hello,
              style: ThemeGenerator().h1XL.copyWith(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}

class BackGroundImage extends StatelessWidget {
  const BackGroundImage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: netWorkOrCacheImageProvider(
            imagePath: AssetCatlog.loginPageBackGround, boxFit: BoxFit.fill),
      ),
    );
  }
}
