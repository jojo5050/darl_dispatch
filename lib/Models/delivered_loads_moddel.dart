class DeliveredLoadDetails {
  final String id;
  final String brokerName;
  final String brokerNumber;
  final String brokerEmail;
  final String shipperEmail;
  final String shipperAddress;
  final String rate;
  final String rateConfirmationID;
  final String dateRegistered;
  // Add more fields as needed

  DeliveredLoadDetails({
    required this.id,
    required this.brokerName,
    required this.brokerNumber,
    required this.brokerEmail,
    required this.shipperEmail,
    required this.shipperAddress,
    required this.rate,
    required this.rateConfirmationID,
    required this.dateRegistered,
    // Initialize more fields as needed
  });

  factory DeliveredLoadDetails.fromJson(Map<String, dynamic> json) {
    return DeliveredLoadDetails(
      id: json['id'],
      brokerName: json['brokerName'],
      brokerNumber: json['brokerNumber'],
      brokerEmail: json['brokerEmail'],
      shipperEmail: json['shipperEmail'],
      shipperAddress: json['shipperAddress'],
      rate: json['rate'],
      rateConfirmationID: json['rateConfirmationID'],
      dateRegistered: json['dateRegistered'],
      // Initialize more fields as needed
    );
  }
}
