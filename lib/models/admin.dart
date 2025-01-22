class Admin {
  final String adminID;
  final String name;
  final String email;
  final String password;

  Admin({
    required this.adminID,
    required this.name,
    required this.email,
    required this.password,
  });

  factory Admin.fromJson(Map<String, dynamic> json) {
    return Admin(
      adminID: json['adminID'],
      name: json['name'],
      email: json['email'],
      password: json['password'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'adminID': adminID,
      'name': name,
      'email': email,
      'password': password,
    };
  }
}
