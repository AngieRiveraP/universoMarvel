import 'package:injectable/injectable.dart';

import '../model/reference_model.dart';


@injectable
mixin DetailReferenceRepository {

  Future<List<Result>> getReference(int offset, String type, String id);

}
