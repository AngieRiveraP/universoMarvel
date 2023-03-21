import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:universo_marvel/detail_reference/view/detail_reference.dart';
import 'package:universo_marvel/home/view/widgets/widgets_home.dart';
import 'package:universo_marvel/resource/strings.dart';
import 'package:universo_marvel/widgets/body_app.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../utils/scale_route.dart';
import '../model/characters_model.dart';

class DetailCharacter extends StatefulWidget {

  const DetailCharacter({Key? key, required this.dataCharacter}) : super(key: key);

  final CharactersData dataCharacter;

  @override
  State<DetailCharacter> createState() => DetailCharacterState();
}

class DetailCharacterState
    extends State<DetailCharacter> {

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context);
        return true;
      },
      child: Scaffold(
        body: BodyApp(
          onBack: true,
          marginBody: false,
          childHeader: Container(),
          childBody: bodyDetail(),
          onBackPressed: (){
            Navigator.pop(context);
          },
        ),
      ),
    );
  }

  Widget bodyDetail(){
    return Container(
      color: const Color(0xff202128),
      child: SingleChildScrollView(
        child: Stack(
          children: [
            SizedBox(
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.60,
              child: FadeInImage(
                  image: NetworkImage(
                      "${widget.dataCharacter.thumbnail.path}.${widget.dataCharacter.thumbnail.extension}"),
                  placeholder: const AssetImage(
                      'assets/icon_image.png'),
                  fit: BoxFit.cover,
                ),
            ),
        Container(
          width: double.infinity,
          margin: EdgeInsets.only(top: (MediaQuery.of(context).size.height * 0.60 - 200)),
          height: 200,
          decoration:  BoxDecoration(
              gradient: LinearGradient(
                  colors: [Colors.transparent,Colors.black.withOpacity(0.5),Colors.black],
                  stops: const [0.1,0.4,0.9],
                  begin: FractionalOffset.topCenter,
                  end: FractionalOffset.bottomCenter
              )
          )),
            Container(
              margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.55),
              padding: const EdgeInsets.all(25),
              width: double.infinity,
              decoration:  const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30.0),
                    topRight: Radius.circular(30.0),
                  ),
                  color: Color(0xff202128)),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Text(
                          widget.dataCharacter.name,
                        textAlign: TextAlign.center,
                          style: const TextStyle(
                              color: Colors.white,
                            fontSize: 25,
                            fontWeight: FontWeight.w700,
                          )
                      ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                        "${Strings.description}:",
                        style:  TextStyle(
                            color: Colors.white.withOpacity(0.7),
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        )
                    ),
                  const SizedBox(
                    height: 15,
                  ),
                  Text(
                        widget.dataCharacter.description,
                        style:  TextStyle(
                            color: Colors.white.withOpacity(0.6),
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                        )
                    ),
                  const SizedBox(
                    height: 25,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: buttonReference(Strings.events,  () {
                          Navigator.push(context, ScaleRoute(page: DetailReference(title : Strings.events, type: "events", dataCharacter: widget.dataCharacter)));
                        }),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: buttonReference(Strings.comics,  () {
                          Navigator.push(context, ScaleRoute(page: DetailReference(title : Strings.comics, type: "comics", dataCharacter: widget.dataCharacter)));
                        }),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: buttonReference(Strings.series,  () {
                          Navigator.push(context, ScaleRoute(page: DetailReference(title : Strings.series, type: "series", dataCharacter: widget.dataCharacter)));
                        }),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: buttonReference(Strings.stories,  () {
                          Navigator.push(context, ScaleRoute(page: DetailReference(title : Strings.stories, type: "stories", dataCharacter: widget.dataCharacter)));
                        }),
                      ),
                    ],
                  ),
                  Visibility(
                    visible: widget.dataCharacter.urls.isNotEmpty,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 25),
                      child: Text(
                          Strings.viewMore,
                          style:  TextStyle(
                            color: Colors.white.withOpacity(0.7),
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          )
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Visibility(
                      visible: widget.dataCharacter.urls.isNotEmpty,
                      child: Text.rich(
                      TextSpan(
                          style: const TextStyle(fontSize: 15,),
                          children: [
                            TextSpan(
                                style: const TextStyle(color: Colors.blue, decoration: TextDecoration.underline),
                                text: widget.dataCharacter.urls[0].url,
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () async {
                                    _launchUrl(widget.dataCharacter.urls[0].url);
                                  }
                            ),

                            //more text paragraph, sentences here.
                          ]
                      )
                  ))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<void> _launchUrl(String url) async {
    if (!await launchUrl(Uri.parse(url))) {
      throw Exception('Could not launch $url');
    }
  }

}
