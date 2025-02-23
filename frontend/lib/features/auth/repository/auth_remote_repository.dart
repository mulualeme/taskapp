import 'dart:convert';
import 'package:frontend/features/auth/repository/auth_local_repository.dart';
import 'package:frontend/models/user_model.dart';
import 'package:http/http.dart' as http;
import 'package:frontend/core/constants/constants.dart';
import 'package:frontend/core/services/sp_service.dart';

class AuthRemoteRepository {
  final spService = SpService();
  final authLocalRepository = AuthLocalRepository();
  Future<UserModel> signUp(
      {required String name,
      required String email,
      required String password}) async {
    try {
      final response =
          await http.post(Uri.parse('${Constants.backendUri}/auth/signup'),
              headers: {
                'Content-Type': 'application/json',
              },
              body: jsonEncode({
                'name': name,
                'email': email,
                'password': password,
              }));

      if (response.statusCode != 201) {
        throw jsonDecode(response.body)['error'];
      }
      return UserModel.fromJson(response.body);
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<UserModel> login(
      {required String email, required String password}) async {
    try {
      final response =
          await http.post(Uri.parse('${Constants.backendUri}/auth/login'),
              headers: {
                'Content-Type': 'application/json',
              },
              body: jsonEncode({'email': email, 'password': password}));

      if (response.statusCode != 200) {
        throw jsonDecode(response.body)['error'];
      }
      return UserModel.fromJson(response.body);
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<UserModel?> getUserData() async {
    try {
      final token = await spService.getToken();
      print(token);
      if (token == null) {
        return null;
      }
      final res = await http.post(
          Uri.parse('${Constants.backendUri}/auth/tokenIsValid'),
          headers: {
            'Content-Type': 'application/json',
            'x-auth-token': token,
          });

      if (res.statusCode != 200 || jsonDecode(res.body) == false) {
        return null;
      }
      final userResponse =
          await http.get(Uri.parse('${Constants.backendUri}/auth'), headers: {
        'Content-Type': 'application/json',
        'x-auth-token': token,
      });
      if (userResponse.statusCode != 200) {
        throw jsonDecode(userResponse.body)['error'];
      }
      print(userResponse.body);

      return UserModel.fromJson(userResponse.body);
    } catch (e) {
      final user = await authLocalRepository.getUser();
      return user;
    }
  }
}
