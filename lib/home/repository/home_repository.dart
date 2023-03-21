import 'package:injectable/injectable.dart';

import '../model/characters_model.dart';

@injectable
mixin HomeRepository {

  Future<List<CharactersData>> getCharacters(int offset);

}
