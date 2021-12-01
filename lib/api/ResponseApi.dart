import 'dart:convert';

import 'dart:developer';

import 'package:http/http.dart';

class ApiResponse<T>{
  bool? ok;
  Map? _body;
  Response? response;

  Map? get body => this._body;

  set body(body){
    if(body.toString().length > 0) this._body = json.decode(body);
    else this._body = null;
  }

  ApiResponse.ok(body, {response = null}){
    ok = true;
    this.body = body;
    this.response = response;
  }

  ApiResponse.error(body, {response = null}){
    ok = false;
    this.body = body;
    this.response = response;
  }
}