class Payment {
  final String paymentID;
  final String userID;
  final String rideID;
  final double amount;
  final String method;
  final DateTime paymentDate;

  Payment({
    required this.paymentID,
    required this.userID,
    required this.rideID,
    required this.amount,
    required this.method,
    required this.paymentDate,
  });

  factory Payment.fromJson(Map<String, dynamic> json) {
    return Payment(
      paymentID: json['paymentID'],
      userID: json['userID'],
      rideID: json['rideID'],
      amount: json['amount'].toDouble(),
      method: json['method'],
      paymentDate: DateTime.parse(json['paymentDate']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'paymentID': paymentID,
      'userID': userID,
      'rideID': rideID,
      'amount': amount,
      'method': method,
      'paymentDate': paymentDate.toIso8601String(),
    };
  }
}
