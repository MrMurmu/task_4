

class AuthModel {
    final String userName;
    final String password;
    final String email;

    AuthModel({
        required this.userName,
        required this.password,
        required this.email,
    });

    factory AuthModel.fromMap(Map<String, dynamic> json) => AuthModel(
        userName: json["userName"],
        password: json["password"],
        email: json["email"],
    );

    Map<String, dynamic> toMap() => {
        "userName": userName,
        "password": password,
        "email": email,
    };
}
