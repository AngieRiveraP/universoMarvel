import 'package:injectable/injectable.dart';

import '../model/reference_model.dart';
import 'detail_reference_repository.dart';

@Injectable(as: DetailReferenceUseCase)
class DetailReferenceUseCaseImpl implements DetailReferenceUseCase {
  final DetailReferenceRepository _homeRepository;

  DetailReferenceUseCaseImpl(this._homeRepository);

  @override
  Future<List<Result>> getReference(int offset, String type, String id) {
    return _homeRepository.getReference(offset, type, id);
  }

}

mixin DetailReferenceUseCase {
  Future<List<Result>> getReference(int offset, String type, String id);
}
