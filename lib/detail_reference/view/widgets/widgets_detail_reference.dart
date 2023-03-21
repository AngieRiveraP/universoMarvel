import 'package:flutter/material.dart';
import 'package:universo_marvel/detail_reference/model/reference_model.dart';

import '../../../widgets/widgets_generics.dart';


Widget shimmerReference() {
  return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 6,
      padding: const EdgeInsets.all(0),
      itemBuilder: (context, index) => itemShimmerReference(),
  );
}

Widget itemShimmerReference() {
  return  Container(
      padding: const EdgeInsets.only(
          top: 10.0, bottom: 10.0, left: 20, right: 20),
      child: const ParagraphShimmerLight(lines: 1, space: 0, height: 20));
}

Widget itemReference(Result data) {
  return Padding(
    padding: const EdgeInsets.only(top: 10, bottom: 10),
    child: Text(
          data.title!,
          style: const TextStyle(
            color: Colors.blueGrey,
            fontSize: 15,
            fontWeight: FontWeight.w500,
          )
      ),
  );
}

Widget itemCreators(String title) {
  return Container(
    padding: const EdgeInsets.only(left: 5, right: 5, top: 15, bottom: 15),
    child: Text(
        title,
        style: TextStyle(
          color: Colors.white.withOpacity(0.7),
          fontSize: 15,
          fontWeight: FontWeight.w400,
        )
    ),
  );
}
