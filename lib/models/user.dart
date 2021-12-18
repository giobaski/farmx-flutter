class User {

  final int id;
  final String username;
  final String email;
  final String accessToken;
  final String tokenType;
  // List<String> roles;


  User({
    required this.id, required this.username, required this.email, required this.accessToken, required this.tokenType
  });

  factory User.fromJson(Map<String, dynamic> json){
    return User(
        id: json['id'],
        username: json['username'],
        email: json['email'],
        accessToken: json['accessToken'],
        tokenType: json['tokenType']
    );
  }


}