import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<List<UserModel>> fetchUsers() async {
  final response = await http.get(Uri.parse('https://randomuser.me/api?results=20'));

  if (response.statusCode == 200) {
    final result = jsonDecode(response.body)['results'] as List;
    List<UserModel> users = [];
  
    for (var u in result) {
      UserModel user = UserModel.fromJson(u);
      users.add(user);
    }
    print(users);
    return users;
  } else {
    throw Exception('Failed to get users');
  }
}

class UserProvider extends ChangeNotifier {
  List<UserModel> users = [];
  var isLoading = false;

  Future<List<UserModel>> getUsers() async {
    users = await fetchUsers();

    notifyListeners();
    return users;
  }
}

class UserModel {
  final Map<String, dynamic> name;
  final Map<String, dynamic> picture;
  final String email;
  final String phone;
  final String gender;

  UserModel({
    required this.name, 
    required this.email, 
    required this.phone,
    required this.gender,
    required this.picture
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      name: json['name'],
      email: json['email'],
      phone: json['phone'],
      picture: json['picture'],
      gender: json['gender']
    );
  }

  String get fullName {
    return '${name['first']} ${name['last']}';
  }
}