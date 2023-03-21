import 'package:flutter/material.dart';

import '../resource/strings.dart';

class NoInternet extends StatelessWidget {


  const NoInternet({super.key,

  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: double.infinity,
      height: double.infinity,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: 200,
              height: 200,
              child: Image.asset('assets/no_internet.png')),
          const SizedBox(
            height: 20,
          ),
          const Text(
              Strings.noInternet,
              style: TextStyle(
                  color: Colors.white
              )
          ),
        ],
      ),
    );
  }
}



