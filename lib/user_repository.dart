import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:user_bloc/users.dart';

abstract class UserRepository {
  Future<List<Users>> getCats();
}

class SampleUserRepository implements UserRepository {
  final url = Uri.parse("https://jsonplaceholder.typicode.com/users");

  @override
  Future<List<Users>> getCats() async {
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final jsonBody = jsonDecode(response.body) as List;
      return jsonBody.map((e) => Users.fromJson(e)).toList();
    } else {
      throw NetworkError(response.statusCode.toString(), response.body);
    }
  }
}

class NetworkError implements Exception {
  final String statusCode;
  final String messsage;

  NetworkError(this.statusCode, this.messsage);
}
