import 'dart:convert';

import 'dart:developer';

class ApiResponse<T>{
  bool? ok;
  Map? _body;

  Map? get body => this._body;

  set body(body){
    if(body.toString().length > 0) this._body = json.decode(body);
    else this._body = null;
  }

  ApiResponse.ok(body){
    ok = true;
    this.body = body;
  }

  ApiResponse.error(body){
    ok = false;
    this.body = body;
  }
}