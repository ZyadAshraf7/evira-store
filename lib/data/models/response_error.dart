class ResponseError {
  Error? error;

  ResponseError({this.error});

  ResponseError.fromJson(Map<String, dynamic> json) {
    error = json['error'] != null ? new Error.fromJson(json['error']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.error != null) {
      data['error'] = this.error!.toJson();
    }
    return data;
  }
}

class Error {
  List<Errors>? errors;
  int? code;
  String? message;

  Error({this.errors, this.code, this.message});

  Error.fromJson(Map<String, dynamic> json) {
    if (json['errors'] != null) {
      errors = <Errors>[];
      json['errors'].forEach((v) {
        errors!.add(new Errors.fromJson(v));
      });
    }
    code = json['code'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.errors != null) {
      data['errors'] = this.errors!.map((v) => v.toJson()).toList();
    }
    data['code'] = this.code;
    data['message'] = this.message;
    return data;
  }
}

class Errors {
  String? domain;
  String? reason;
  String? message;

  Errors({this.domain, this.reason, this.message});

  Errors.fromJson(Map<String, dynamic> json) {
    domain = json['domain'];
    reason = json['reason'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['domain'] = this.domain;
    data['reason'] = this.reason;
    data['message'] = this.message;
    return data;
  }
}