import 'package:flutter/material.dart';

import '../../../widgets/widgets_generics.dart';
import '../../model/characters_model.dart';

Widget shimmerHome() {
  return ListView.builder(
    shrinkWrap: true,
    physics: const NeverScrollableScrollPhysics(),
    itemCount: 6,
    padding: const EdgeInsets.only(
        top: 20.0, bottom: 20.0),
    itemBuilder: (context, index) => homeShimmer(),
  );
}

Widget homeShimmer() {
  return Container(
    margin: const EdgeInsets.only(bottom: 25, left: 25, right: 25),
    decoration:  BoxDecoration(
        border: Border.all(color: Colors.white.withOpacity(0.4)),
        borderRadius: const BorderRadius.all(
          Radius.circular(15.0),
        )),
    child: Stack(
      alignment: Alignment.bottomCenter,
      children: [
        SizedBox(
          width: double.infinity,
          height: 250.0,
          child: Image.asset('assets/icon_image.png'),
        ),
        Container(
          width: double.infinity,
          alignment: Alignment.centerRight,
          padding: const EdgeInsets.all(10),
          margin: const EdgeInsets.only(left: 70),
          decoration:  BoxDecoration(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(30.0),
              ),
              color: Colors.black.withOpacity(0.6)),
          child:   const ParagraphShimmer(lines: 1, space: 0, height: 20),
        ),
      ],
    ),
  );
}

Widget itemCharacters(CharactersData data) {
  return Container(
    margin: const EdgeInsets.only(bottom: 25, left: 25, right: 25),
    decoration:  BoxDecoration(
        border: Border.all(color: Colors.white.withOpacity(0.4)),
        borderRadius: const BorderRadius.all(
          Radius.circular(15.0),
        )),
      child: Stack(
        alignment: Alignment.bottomCenter,
      children: [
        SizedBox(
          width: double.infinity,
          height: 250.0,
          child: ClipRRect(
            borderRadius:
            BorderRadius.circular(
                15.0),
            child: FadeInImage(
              image: NetworkImage(
                  "${data.thumbnail.path}.${data.thumbnail.extension}"),
              placeholder: const AssetImage(
                  'assets/icon_image.png'),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Container(
          width: double.infinity,
          alignment: Alignment.centerRight,
          padding: const EdgeInsets.all(10),
          margin: const EdgeInsets.only(left: 70),
          decoration:  BoxDecoration(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(30.0),
              ),
              color: Colors.black.withOpacity(0.6)),
          child: Text(
            data.name,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            )
          ),
        ),
      ],
    ),
  );
}

Widget buttonReference(String title, Function onSelect) {
  return Container(
    height: 40,
    decoration: BoxDecoration(
        gradient: const LinearGradient(
            colors: [
              Color.fromRGBO(93, 202, 214, 1),
              Color.fromRGBO(79, 165, 172, 1),
              Color.fromRGBO(60, 142, 131, 1),
            ],
            stops: [0.1,0.6,0.9],
            begin: FractionalOffset.topCenter,
            end: FractionalOffset.bottomCenter),
        borderRadius: BorderRadius.circular(5),
    ),
    child: ElevatedButton(
      onPressed: () {
        onSelect();
      },
      style: ElevatedButton.styleFrom(
        minimumSize: Size.zero, // Set this
        padding: EdgeInsets.zero,
        primary: Colors.transparent,
        onSurface: Colors.transparent,
        shadowColor: Colors.transparent,
        //make color or elevated button transparent
      ),
      child: Container(
          alignment: Alignment.center,
          child: Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              )
          ),
      ),
    ),
  );
}



