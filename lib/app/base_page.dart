import 'package:flutter/material.dart';

import '../di/dependecy_injection.dart';
import '../utils/bloc/bloc.dart';
import '../utils/bloc/provider.dart';

abstract class BasePage<T extends StatefulWidget, K extends Bloc>
    extends State<T> {
  K? bloc;


  @override
  void initState() {
    super.initState();
    bloc = Provider.of<K>(_getBlocInstance);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    Provider.dispose<K>();
    super.dispose();
  }

  void onBuildCompleted(Duration timeStamp) {
    //Do Something
  }

  K _getBlocInstance() {
    return getIt<K>();
  }

}
