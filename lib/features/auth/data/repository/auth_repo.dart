import 'package:ccd2023/configurations/configurations.dart';
import 'package:ccd2023/features/app/data/repository/dio/dio_api_client.dart';
import 'package:ccd2023/features/auth/auth.dart';
import 'package:dio/dio.dart';

class AuthenticationRepository {
  final DioApiClient _dioApiClient;

  AuthenticationRepository(this._dioApiClient);

  Future<LoginResponse> signIn({
    required String username,
    required String email,
    required String password,
  }) async {
    Response response = await _dioApiClient.postData(loginEndpoint, {
      'username': username,
      'email': email,
      'password': password,
    });

    final loginResponse = LoginResponse.fromJson(response.data);

    return loginResponse;
  }

  Future signUp({
    required String username,
    required String email,
    required String password,
  }) async {
    Response response = await _dioApiClient.postData(registrationEndpoint, {
      'username': username,
      'email': email,
      'password1': password,
      'password2': password,
    });

    final signUpResponse = response.data;

    // print(signUpResponse);

    // return signUpResponse;
  }

  Future resetPassword({
    required String email,
  }) async {
    Response response = await _dioApiClient.postData(passwordResetEndpoint, {
      'email': email,
    });

    final resetResponse = response.data;

    // print(signUpResponse);

    // return signUpResponse;
  }
}
