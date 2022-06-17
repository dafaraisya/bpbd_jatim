class User {
  String? id;
  String? username;
  String? email;

  User({ this.id, this.username, this.email });

  User.fromJson(Map<String, dynamic> json)
    : id = json['id'],
      username = json['username'],
      email = json['email'];

  Map<String, dynamic> toJson() => {
    'id': id,
    'username': username,
    'email': email,
  };
}