class Van {
  final String vanNumber;
  final String plateNumber;
  final int capacity;
  final String specifiedRoute;
  final String driverID;

  Van({
    required this.vanNumber,
    required this.plateNumber,
    required this.capacity,
    required this.specifiedRoute,
    required this.driverID,
  });

  factory Van.fromJson(Map<String, dynamic> json) {
    return Van(
      vanNumber: json['vanNumber'],
      plateNumber: json['plateNumber'],
      capacity: json['capacity'],
      specifiedRoute: json['specifiedRoute'],
      driverID: json['driverID'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'vanNumber': vanNumber,
      'plateNumber': plateNumber,
      'capacity': capacity,
      'specifiedRoute': specifiedRoute,
      'driverID': driverID,
    };
  }
}
