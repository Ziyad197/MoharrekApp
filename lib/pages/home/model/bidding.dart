class Auction {
  String carId; // Unique identifier for the participant in the auction
  String participantId; // Unique identifier for the participant in the auction
  String participantName; // Name of the participant in the auction
  double amount; // The amount bid by the participant
  String date; // The date of the bid
  DateTime expiryDate; // Expiry date for the bidding

  Auction({
    required this.carId, // Updated parameter name
    required this.participantId, // Updated parameter name
    required this.participantName, // Updated parameter name
    required this.amount, // Updated parameter name
    required this.date, // Updated parameter name
    required this.expiryDate,
  });

  factory Auction.fromJson(Map<String, dynamic> json) {
    return Auction(
      carId: json['carId'],
      participantId: json['participantId'],
      participantName: json['participantName'],
      amount: json['amount'].toDouble(),
      date: json['date'],
      expiryDate: DateTime.parse(json['expiryDate']), // Parse expiry date from JSON
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'carId': carId,
      'participantId': participantId,
      'participantName': participantName,
      'amount': amount,
      'date': date,
      'expiryDate': expiryDate.toIso8601String(), // Convert expiry date to string
    };
  }
}
