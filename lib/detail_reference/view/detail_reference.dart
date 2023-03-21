import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:universo_marvel/detail_reference/model/reference_model.dart';
import 'package:universo_marvel/detail_reference/view/widgets/widgets_detail_reference.dart';

import '../../app/base_page.dart';
import '../../home/model/characters_model.dart';
import '../../resource/strings.dart';
import '../../utils/scale_route.dart';
import '../../widgets/body_app.dart';
import '../../widgets/widgets_generics.dart';
import '../bloc/detail_reference_bloc.dart';
import 'detail_item_reference.dart';

class DetailReference extends StatefulWidget {

  const DetailReference({Key? key, required this.dataCharacter, required this.type, required this.title}) : super(key: key);

  final CharactersData dataCharacter;
  final String type;
  final String title;

  @override
  State<DetailReference> createState() => DetailReferenceState();
}

class DetailReferenceState
    extends BasePage<DetailReference, DetailReferenceBloc> {

  final RefreshController _refreshReference = RefreshController(initialRefresh: false);

  @override
  void initState() {
    super.initState();
    bloc!.getReference(widget.type, widget.dataCharacter.id.toString(), true);
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
    return  Stack(
          alignment: Alignment.topCenter,
          children: [
            Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height,
                decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(
                        "${widget.dataCharacter.thumbnail.path}.${widget.dataCharacter.thumbnail.extension}"),
                    )
                ),
              ),
            Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.8),
              ),
            ),
            Container(
                width: double.infinity,
                height: double.infinity,
                margin: const EdgeInsets.only(top: 250, left: 60, right: 60, bottom: 20),
                padding: const EdgeInsets.only(top: 190, bottom: 10, left: 20, right: 20),
                decoration: const BoxDecoration(
                    color: Colors.white70,
                    borderRadius: BorderRadius.all(
                      Radius.circular(25.0),
                    )),
                child: viewDetailListReference()),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 200,
                  height: 300,
                  margin: const EdgeInsets.only(top: 100),
                  child: ClipRRect(
                    borderRadius:
                    BorderRadius.circular(
                        25.0),
                    child: FadeInImage(
                      image: NetworkImage(
                          "${widget.dataCharacter.thumbnail.path}.${widget.dataCharacter.thumbnail.extension}"),
                      placeholder: const AssetImage(
                          'assets/png.jpeg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Container(
            alignment: Alignment.topCenter,
            child:Text(
                widget.title,
                style: const TextStyle(
                  color: Colors.blueGrey,
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                )
            ),
          ),
              ],
            ),
          ],
        );
  }

  Widget viewDetailListReference(){
    return    StreamBuilder<bool>(
      stream: bloc!.isLoadingStream,
      builder: (context, snapshotLoading) {
        var loading = true;
        if (snapshotLoading.hasData) {
          loading = snapshotLoading.data!;
        }
        return StreamBuilder (
          stream: bloc!.listReferenceStream,
          builder: (context, snapshot) {
            List<Result> data = [];
            if (snapshot.hasData) {
              data = snapshot.data!;
            }
            return StreamBuilder (
              stream: bloc!.typeErrorStream,
              builder: (context, snapshotError) {
                var typeError = "";
                if (snapshotError.hasData) {
                  typeError = snapshotError.data!;
                }
                return loading ? shimmerReference() : viewReference(data, typeError);
               // return shimmerReference() ;
              },
            );
          },
        );
      },
    );
  }

  Widget viewReference(List<Result> data, String typeError) {
    return  data.isNotEmpty ? viewListReference(data) :
    typeError == "noInternet" ? emptyReference(Strings.noInternet)  :  emptyReference(Strings.emptyData);
  }

  Widget emptyReference(String title) {
    return Text(
          title ,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Colors.blueGrey,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          )
    );
  }

  Widget viewListReference(List<Result> data) {
    return SmartRefresher(
        controller: _refreshReference,
        enablePullDown: false,
        enablePullUp: true,
        onLoading: onLoading,
        footer: loadingMore(),
        child: ListView.builder(
            itemCount: data.length,
            physics: const BouncingScrollPhysics(),
            shrinkWrap: true,
            padding: const EdgeInsets.all(0),
            itemBuilder: (_, index) {
              return InkWell(
                onTap: (){
                  Navigator.push(context, ScaleRoute(page: DetailItemReference(dataReference: data[index], dataCharacter: widget.dataCharacter)));
                },
                child: itemReference(data[index]),
              );
            }),
      );
  }

  void onLoading() async{
    await Future.delayed(const Duration(milliseconds: 800));
    bloc!.getReference(widget.type, widget.dataCharacter.id.toString(), false);
    _refreshReference.loadComplete();
  }

}
