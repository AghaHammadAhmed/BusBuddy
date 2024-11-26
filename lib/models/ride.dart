class Ride {
  final String rideID;
  final String userID;
  final String busID;
  final String startLocation;
  final String endLocation;
  final DateTime rideTime;
  final String status;

  Ride({
    required this.rideID,
    required this.userID,
    required this.busID,
    required this.startLocation,
    required this.endLocation,
    required this.rideTime,
    required this.status,
  });

  factory Ride.fromJson(Map<String, dynamic> json) {
    return Ride(
      rideID: json['rideID'],
      userID: json['userID'],
      busID: json['busID'],
      startLocation: json['startLocation'],
      endLocation: json['endLocation'],
      rideTime: DateTime.parse(json['rideTime']),
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'rideID': rideID,
      'userID': userID,
      'busID': busID,
      'startLocation': startLocation,
      'endLocation': endLocation,
      'rideTime': rideTime.toIso8601String(),
      'status': status,
    };
  }
}
