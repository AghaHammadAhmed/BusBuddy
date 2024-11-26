class Driver {
  final String driverID;
  final String name;
  final int age;
  final String phone;
  final String drivingLicenseNumber;
  final String password;

  Driver({
    required this.driverID,
    required this.name,
    required this.age,
    required this.phone,
    required this.drivingLicenseNumber,
    required this.password,
  });

  factory Driver.fromJson(Map<String, dynamic> json) {
    return Driver(
      driverID: json['driverID'],
      name: json['name'],
      age: json['age'],
      phone: json['phone'],
      drivingLicenseNumber: json['drivingLicenseNumber'],
      password: json['password'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'driverID': driverID,
      'name': name,
      'age': age,
      'phone': phone,
      'drivingLicenseNumber': drivingLicenseNumber,
      'password': password,
    };
  }
}
