import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:universo_marvel/app/app_settings.dart';
import 'package:universo_marvel/app/application.dart';
import 'package:universo_marvel/di/dependecy_injection.dart';
import 'package:universo_marvel/home/model/characters_model.dart';
import 'package:universo_marvel/home/repository/home_api.dart';
import 'package:universo_marvel/utils/constants.dart';

class HomeRepositoryImplTest extends Mock implements HomeRepositoryImpl {}

void main() {
  final HomeRepositoryImplTest homeRepositoryImplTest =
      HomeRepositoryImplTest();

  setUp(() {
    final AppSettings appSettings = AppSettings(
      url: Constants.url,
    );
    Application().appSettings = appSettings;
    configureDependencies();
  });

  test('load home', () async {

    List<CharactersData> expected = [];
    Thumbnail dataThumbnail = Thumbnail(path: "", extension: "");
    var data = CharactersData(id: 1, name: "Iron Man", description: "-", modified: "", thumbnail: dataThumbnail, urls: []);
    expected.add(data);
    when(() => homeRepositoryImplTest.getCharacters(0)).thenAnswer((_) async => expected);
    var resultStartFlow = await homeRepositoryImplTest.getCharacters(0);
    expect(resultStartFlow, expected);
    print('load home');

  });

}
