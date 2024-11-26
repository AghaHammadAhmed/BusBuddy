class User {
  final String userID;
  final String name;
  final String email;
  final int age;
  final String gender;
  final String phone;
  final String address;
  final String password;

  User({
    required this.userID,
    required this.name,
    required this.email,
    required this.age,
    required this.gender,
    required this.phone,
    required this.address,
    required this.password,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      userID: json['userID'],
      name: json['name'],
      email: json['email'],
      age: json['age'],
      gender: json['gender'],
      phone: json['phone'],
      address: json['address'],
      password: json['password'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userID': userID,
      'name': name,
      'email': email,
      'age': age,
      'gender': gender,
      'phone': phone,
      'address': address,
      'password': password,
    };
  }
}
