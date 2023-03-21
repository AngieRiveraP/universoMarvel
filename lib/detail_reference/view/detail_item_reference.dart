
import 'package:flutter/material.dart';
import 'package:universo_marvel/detail_reference/model/reference_model.dart';
import 'package:universo_marvel/detail_reference/view/widgets/widgets_detail_reference.dart';

import '../../home/model/characters_model.dart';
import '../../resource/strings.dart';
import '../../widgets/body_app.dart';
import '../../widgets/configurable_expansion_tile_null_safety.dart';


class DetailItemReference extends StatefulWidget {

  const DetailItemReference({Key? key, required this.dataReference, required this.dataCharacter}) : super(key: key);

  final Result dataReference;
  final CharactersData dataCharacter;

  @override
  State<DetailItemReference> createState() => DetailItemReferenceState();
}

class DetailItemReferenceState
    extends State<DetailItemReference> {

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
        backgroundColor: Colors.black,
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
                    widget.dataReference.thumbnail == null ? "${widget.dataCharacter.thumbnail.path}.${widget.dataCharacter.thumbnail.extension}" :
                "${widget.dataReference.thumbnail!.path}.${widget.dataReference.thumbnail!.extension}"),
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
                        widget.dataReference.title!,
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
                      widget.dataReference.description!,
                      style:  TextStyle(
                        color: Colors.white.withOpacity(0.6),
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                      )
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  widget.dataReference.characters != null ?  ConfigurableExpansionTile(
                    initiallyExpanded: false,
                    header: const Text(Strings.characters,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        )),
                    animatedWidgetFollowingHeader: const Icon(
                      Icons.keyboard_arrow_down_rounded,
                      color: Colors.white,
                      size: 24.0,
                    ),
                    childrenBody: ListView.separated(
                        itemCount: widget.dataReference.characters!.items.length,
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                        itemBuilder: (_, index) {
                          return itemCreators(widget.dataReference.characters!.items[index].name);
                        },
                        separatorBuilder: (BuildContext context, int index) {
                          return Divider(
                            height: 1,
                            color: Colors.white.withOpacity(0.3),
                          );
                        }),
                  ) : Container(),
                  const SizedBox(
                    height: 15,
                  ),
                  widget.dataReference.creators != null ? ConfigurableExpansionTile(
                    initiallyExpanded: false,
                    header: const Text(Strings.creators,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        )),
                    animatedWidgetFollowingHeader: const Icon(
                        Icons.keyboard_arrow_down_rounded,
                        color: Colors.white,
                        size: 24.0,
                      ),
                    childrenBody:
                    ListView.separated(
                        itemCount: widget.dataReference.creators!.items.length,
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                        itemBuilder: (_, index) {
                          return itemCreators(widget.dataReference.creators!.items[index].name);
                        },
                        separatorBuilder: (BuildContext context, int index) {
                          return Divider(
                            height: 1,
                            color: Colors.white.withOpacity(0.3),
                          );
                        }),
                  ) : Container(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }


}
