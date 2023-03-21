import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:universo_marvel/home/view/widgets/widgets_home.dart';
import 'package:universo_marvel/widgets/body_app.dart';
import 'package:universo_marvel/widgets/empty_view.dart';
import 'package:universo_marvel/widgets/no_internet.dart';

import '../../app/base_page.dart';
import '../../utils/scale_route.dart';
import '../../widgets/widgets_generics.dart';
import '../bloc/home_bloc.dart';
import '../model/characters_model.dart';
import 'detail_character.dart';

class HomePage extends StatefulWidget {

  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => HomePageState();
}

class HomePageState
    extends BasePage<HomePage, HomeBloc> {

  final RefreshController _refreshHome = RefreshController(initialRefresh: false);

  @override
  void initState() {
    super.initState();
    bloc!.getCharacters(true);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        SystemNavigator.pop();
        return true;
      },
      child: Scaffold(
        backgroundColor: Colors.black,
        body: BodyApp(
          onBack: false,
          marginBody: true,
          childHeader: bodyHeader(),
          childBody: bodyHome(),
        ),
      ),
    );
  }

  Widget bodyHeader(){
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.only(top: 12, bottom: 12),
      child: Image.asset('assets/header.png'),
    );
  }

    Widget bodyHome(){
    return  Padding(
      padding: EdgeInsets.only(top: MediaQuery.of(context).size.width * 0.15),
      child: StreamBuilder<bool>(
        stream: bloc!.isLoadingStream,
        builder: (context, snapshotLoading) {
          var loading = true;
          if (snapshotLoading.hasData) {
            loading = snapshotLoading.data!;
          }
          return StreamBuilder (
            stream: bloc!.listCharactersStream,
            builder: (context, snapshot) {
              List<CharactersData> data = [];
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
                  return loading ? shimmerHome() : viewCharacters(data, typeError);
                },
              );
            },
          );
        },
      ),
    );
  }

  Widget viewCharacters(List<CharactersData> data, String typeError) {
    return  data.isNotEmpty ? viewListCharacters(data) :
     typeError == "noInternet" ? const NoInternet()  : const EmptyView();
  }

  Widget viewListCharacters(List<CharactersData> data) {
    return SmartRefresher(
      controller: _refreshHome,
      enablePullDown: false,
      enablePullUp: true,
      onLoading: onLoading,
      footer: loadingMore(),
      child: ListView.builder(
          itemCount: data.length,
          physics: const BouncingScrollPhysics(),
          shrinkWrap: true,
          padding: const EdgeInsets.only(top: 20.0, bottom: 20.0),
          itemBuilder: (_, index) {
            return InkWell(
              onTap: (){
                Navigator.push(context, ScaleRoute(page: DetailCharacter(dataCharacter: data[index])));
              },
              child: itemCharacters(data[index]),
            );
          }),
    );
  }

  void onLoading() async{
    await Future.delayed(const Duration(milliseconds: 800));
    _refreshHome.loadComplete();
    bloc!.getCharacters(false);
  }

}
