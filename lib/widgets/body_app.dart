import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class BodyApp extends StatelessWidget {
  const BodyApp({
    super.key,
    this.childHeader,
    required this.childBody,
    this.onBackPressed,
    required this.onBack,
    required this.marginBody,
  });

  final Widget? childHeader;
  final Widget childBody;
  final VoidCallback? onBackPressed;
  final bool onBack;
  final bool marginBody;

  @override
  Widget build(BuildContext context) {
    double sizeHeightHeader = MediaQuery.of(context).padding.top;
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(statusBarColor: Colors.transparent,  systemNavigationBarIconBrightness: Brightness.light,
      statusBarIconBrightness: Brightness.light,
      statusBarBrightness: Brightness.dark));
    return Container(
      height: MediaQuery.of(context).size.height,
      color: Colors.black,
      child: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                SizedBox(
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      child: Padding(
                        padding: EdgeInsets.only(top: marginBody ? sizeHeightHeader : 0),
                        child: childBody,
                      ),
                    ),
                Container(
                  height: MediaQuery.of(context).size.width * 0.15,
                  margin: EdgeInsets.only(top: sizeHeightHeader),
                  child: Stack(
                    alignment: Alignment.centerLeft,
                    children: <Widget>[
                      Visibility(
                          visible: childHeader != null,
                          child: childHeader!
                      ),
                      Visibility(
                        visible: onBack,
                        child: Container(
                          margin: const EdgeInsets.only(left: 20),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white.withOpacity(0.4)
                          ),
                          child: IconButton(
                            icon: const Icon(
                              Icons.arrow_back,
                              color: Colors.white,
                              size: 24.0,
                            ),
                            onPressed: onBackPressed,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ));
  }
}
