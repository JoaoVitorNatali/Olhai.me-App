class ApiResponse<T>{
  bool? ok;
  String? _msg;
  T? resultado = null;

  String? get msg => this._msg;

  ApiResponse.ok(this.resultado){
    ok = true;
  }

  ApiResponse.error(this._msg){
    ok = false;
  }
}