import 'package:injectable/injectable.dart';

import '../model/characters_model.dart';
import 'home_repository.dart';

@Injectable(as: HomeUseCase)
class HomeUseCaseImpl implements HomeUseCase {
  final HomeRepository _homeRepository;

  HomeUseCaseImpl(this._homeRepository);

  @override
  Future<List<CharactersData>> getCharacters(int offset) {
    return _homeRepository.getCharacters(offset);
  }

}

mixin HomeUseCase {
  Future<List<CharactersData>> getCharacters(int offset);
}
