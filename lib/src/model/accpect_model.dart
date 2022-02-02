class AcceptModel {
  AcceptModel({
    required this.status,
    required this.msg,
    required this.user,
    required this.token,
  });

  int status;
  String msg;
  User user;
  String token;

  factory AcceptModel.fromJson(Map<String, dynamic> json) => AcceptModel(
    status: json["status"],
    msg: json["msg"],
    user: User.fromJson(json["user"]),
    token: json["token"],
  );
}

class User {
  User({
    required this.complete,
  });

  int complete;

  factory User.fromJson(Map<String, dynamic> json) => User(
    complete: json["complete"],
  );
}