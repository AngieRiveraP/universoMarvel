import 'package:injectable/injectable.dart';
import 'package:universo_marvel/utils/constants.dart';
import 'package:universo_marvel/utils/encrypt.dart';

import '../../app/api_source.dart';
import '../model/reference_model.dart';
import 'detail_reference_repository.dart';


@Injectable(as: DetailReferenceRepository)
class DetailReferenceRepositoryImpl implements DetailReferenceRepository {
  final ApiSource _apiSource;

  DetailReferenceRepositoryImpl(this._apiSource);

  @override
  Future<List<Result>> getReference(int offset, String type, String id) async {
    String timestamp = DateTime.now().millisecondsSinceEpoch.toString();
    var hash = await Encrypt.encryptMD5();
    final Uri url = Uri.parse("${_apiSource.baseUrl}/$id/$type?apikey=${Constants.publicKey}&hash=$hash&ts=$timestamp&offset=$offset");
    return _apiSource.getService(url, (value) {
      var result = ReferenceModel.fromJson(value);
      return result.data.results;
    });
  }


}
