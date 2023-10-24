import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:travee/api/api.dart';

class MockAuthClient extends Mock implements TraveeAPI {}

void main() {
  testWidgets('Auth Repository -> HTTP Client', (tester) async {
    // // setup
    // final mockAuthClient = MockAuthClient();
    // final client = Dio();
    // final api = TraveeAPI(client);
    // final authRepository = AuthRepository(api: api);
    // when(() => mockAuthClient.post(
    //         path: 'auth', body: {'email': "email", 'password': "password"}))
    //     .thenAnswer((invocation) async =>
    //         Response(statusCode: 200, requestOptions: RequestOptions()));
    // // run
    // final response =
    //     await authRepository.login(email: "email", password: "password");
    // // verify
    // expect(response, {});
  });
}
