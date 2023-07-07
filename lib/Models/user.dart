class User {
  String? status;
  Data? data;
  String? message;
  int? code;

  User({this.status, this.data, this.message, this.code});

  User.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    message = json['message'];
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['message'] = this.message;
    data['code'] = this.code;
    return data;
  }
}

class Data {
  String? jwtToken;
  User? user;
  Globals? globals;

  Data({this.jwtToken, this.user, this.globals});

  Data.fromJson(Map<String, dynamic> json) {
    jwtToken = json['jwt_token'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    globals =
    json['globals'] != null ? new Globals.fromJson(json['globals']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['jwt_token'] = this.jwtToken;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    if (this.globals != null) {
      data['globals'] = this.globals!.toJson();
    }
    return data;
  }
}


class Notifications {
  bool? emailNewContent;
  bool? emailNewStream;
  bool? emailNewMention;
  bool? appNewContent;
  bool? appNewStream;
  bool? appNewMention;

  Notifications(
      {this.emailNewContent,
        this.emailNewStream,
        this.emailNewMention,
        this.appNewContent,
        this.appNewStream,
        this.appNewMention});

  Notifications.fromJson(Map<String, dynamic> json) {
    emailNewContent = json['email_new_content'];
    emailNewStream = json['email_new_stream'];
    emailNewMention = json['email_new_mention'];
    appNewContent = json['app_new_content'];
    appNewStream = json['app_new_stream'];
    appNewMention = json['app_new_mention'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email_new_content'] = this.emailNewContent;
    data['email_new_stream'] = this.emailNewStream;
    data['email_new_mention'] = this.emailNewMention;
    data['app_new_content'] = this.appNewContent;
    data['app_new_stream'] = this.appNewStream;
    data['app_new_mention'] = this.appNewMention;
    return data;
  }
}

class Globals {
  String? baseCurrency;
  String? sId;
  String? minimumSubscription;
  String? createdAt;
  String? updatedAt;
  int? iV;

  Globals(
      {this.baseCurrency,
        this.sId,
        this.minimumSubscription,
        this.createdAt,
        this.updatedAt,
        this.iV});

  Globals.fromJson(Map<String, dynamic> json) {
    baseCurrency = json['base_currency'];
    sId = json['_id'];
    minimumSubscription = json['minimum_subscription'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['base_currency'] = this.baseCurrency;
    data['_id'] = this.sId;
    data['minimum_subscription'] = this.minimumSubscription;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}




