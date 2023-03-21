import 'package:injectable/injectable.dart';
import 'package:universo_marvel/utils/constants.dart';
import 'package:universo_marvel/utils/encrypt.dart';

import '../../app/api_source.dart';
import '../model/characters_model.dart';
import 'home_repository.dart';

@Injectable(as: HomeRepository)
class HomeRepositoryImpl implements HomeRepository {
  final ApiSource _apiSource;

  HomeRepositoryImpl(this._apiSource);

  @override
  Future<List<CharactersData>> getCharacters(int offset) async {
    String timestamp = DateTime.now().millisecondsSinceEpoch.toString();
    var hash = await Encrypt.encryptMD5();
    final Uri url = Uri.parse("${_apiSource.baseUrl}?apikey=${Constants.publicKey}&hash=$hash&ts=$timestamp&offset=$offset");
    return _apiSource.getService(url, (value) {
      var characters = CharactersModel.fromJson(value);
      return characters.data.results;
    });
  }

}
