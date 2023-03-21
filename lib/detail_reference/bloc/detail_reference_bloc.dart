
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';

import '../../utils/bloc/bloc.dart';
import '../model/reference_model.dart';
import '../repository/detail_reference_use_case.dart';


@injectable
class DetailReferenceBloc with Bloc {

  final DetailReferenceUseCase _detailReferenceUseCase;

  DetailReferenceBloc(this._detailReferenceUseCase);

  final _isLoadingSubject = BehaviorSubject<bool>();
  Function(bool) get isLoadingSink => _isLoadingSubject.sink.add;
  Stream<bool> get isLoadingStream => _isLoadingSubject.stream;

  final _typeErrorSubject = BehaviorSubject<String>();
  Function(String) get typeErrorSink => _typeErrorSubject.sink.add;
  Stream<String> get typeErrorStream => _typeErrorSubject.stream;
  String? get typeError => _typeErrorSubject.value;

  final _listReferenceSubject = BehaviorSubject<List<Result>>();
  Function(List<Result>) get listReferenceSink => _listReferenceSubject.sink.add;
  Stream<List<Result>> get listReferenceStream => _listReferenceSubject.stream;
  List<Result>? get listReference => _listReferenceSubject.value;

  int offset = 0;
  
  @override
  void dispose() {
    _isLoadingSubject.close();
    _listReferenceSubject.close();
  }

  void getReference(String type, String id, bool initial) {
    if(!initial){
      if((offset+20) == listReference!.length) {
        offset += 20;
      }
    }
    _detailReferenceUseCase.getReference(offset, type, id).then((value) {
      if(offset == 0){
        listReferenceSink(value);
      } else {
        List<Result> list = [];
        list.addAll(listReference!);
        list.addAll(value);
        listReferenceSink(list);
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
