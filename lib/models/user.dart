import 'package:meta/meta.dart';

class User {
  String id;
  String username;
  String email;
  String mobile;
  String token;
  String userQR;

  User({@required this.token, this.id, this.username, this.email, this.mobile, this.userQR});

  factory User.fromJson(json) {
    return User(
      token: json['token'],
      id: json['_id'],
      username: json['name'],
      email: json['email'],
      userQR: json['qrcode']['qrcode_url'],
    );
  }
}
