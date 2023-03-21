
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';

import '../../utils/bloc/bloc.dart';
import '../model/characters_model.dart';
import '../repository/home_use_case.dart';


@injectable
class HomeBloc with Bloc {

  final HomeUseCase _homeUseCase;

  HomeBloc(this._homeUseCase);

  final _isLoadingSubject = BehaviorSubject<bool>();
  Function(bool) get isLoadingSink => _isLoadingSubject.sink.add;
  Stream<bool> get isLoadingStream => _isLoadingSubject.stream;

  final _typeErrorSubject = BehaviorSubject<String>();
  Function(String) get typeErrorSink => _typeErrorSubject.sink.add;
  Stream<String> get typeErrorStream => _typeErrorSubject.stream;
  String? get typeError => _typeErrorSubject.value;

  final _listCharactersSubject = BehaviorSubject<List<CharactersData>>();
  Function(List<CharactersData>) get listCharactersSink => _listCharactersSubject.sink.add;
  Stream<List<CharactersData>> get listCharactersStream => _listCharactersSubject.stream;
  List<CharactersData>? get listCharacters => _listCharactersSubject.value;

  int offset = 0;

  @override
  void dispose() {
    _isLoadingSubject.close();
    _listCharactersSubject.close();
    _typeErrorSubject.close();
  }

  void getCharacters(bool initial) {
    if(!initial){
      if((offset+20) == listCharacters!.length) {
        offset += 20;
      }
    }
    _homeUseCase.getCharacters(offset).then((value) {
      if(offset == 0){
        listCharactersSink(value);
      } else {
        List<CharactersData> list = [];
        list.addAll(listCharacters!);
        list.addAll(value);
        listCharactersSink(list);
      }
    }).catchError((onError) {
      if(offset == 0){
        if (onError.errorCode == 'noInternet') {
          typeErrorSink("noInternet");
        } else {
          typeErrorSink("generic");
        }
      }
    }).whenComplete(() => isLoadingSink(false));
  }

}
