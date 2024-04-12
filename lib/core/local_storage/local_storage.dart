import 'dart:async';
import 'dart:convert';

import 'package:maids/features/todo/data/models/get_todos_model.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/subjects.dart';
import 'package:shared_preferences/shared_preferences.dart';


class LocalStorage {
  LocalStorage() {
    _init();
  }

  late SharedPreferences
      sharedPreference; // Creating object of SharedPreferences class.

  Future<void> _init() async {
    sharedPreference = await SharedPreferences
        .getInstance(); //Instantiating the object of SharedPreferences class.
  }

  @override
  List<String>? getTodos() => sharedPreference.getStringList("list");

  @override
  Future<void> saveTodo(List<String> todo) async {
    sharedPreference.setStringList("list", todo);

    //This command stores our usrList with key "list" in the local storage
  }


}
