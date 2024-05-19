import 'bidding.dart';

enum Type {
  NEW,
  USED,
  AUCTION
}
enum GearFilter {
  All,
  Manual,
  Automatic,
}

enum CarStatus{
  PAID,
  AUCTION
}
class Car {
  String carId;
  String model;
  String make;
  int year;
  bool paid;
  bool available;
  String seller;
  String paidBy;
  String description;
  String company;
  String sellerId;
  String sellerPhone;
  Type type;
  double price;
  dynamic bidPrice;
  String location;
  int mileage;
  String uploadDate;
  String expireDate;
  String addDate;
  String transmissionType;
  List<String> images;
  List<Auction> auctions;


  Car({
    required this.carId,
    required this.model,
    required this.paidBy,
    required this.paid,
    required this.make,
    required this.year,
    required this.available,
    required this.seller,
    required this.sellerId,
    required this.sellerPhone,
    required this.type,
    required this.price,
    required this.location,
    required this.mileage,
    required this.uploadDate,
    required this.expireDate,
    required this.addDate,
    required this.transmissionType,
    required this.description,
    required this.company,
    required this.images,
    required this.bidPrice,
    required this.auctions,
  });

  factory Car.fromJson(Map<String, dynamic> json) {
    return Car(
      carId: json['carId'] ?? '',
      paid: json['paid'] ?? false,
      available: json['available'] ?? false,
      model: json['model'] ?? '',
      make: json['make'] ?? '',
      paidBy: json['paidBy'] ?? '',
      year: json['year'] ?? 0,
      seller: json['seller'] ?? '',
      sellerPhone: json['sellerPhone'] ?? '',
      sellerId: json['sellerId'] ?? '',
      type: _parseType(json['type']) ?? Type.USED,
      price: json['price']?.toDouble() ?? 0.0,
      location: json['location'] ?? '',
      mileage: json['mileage'] ?? 0,
      bidPrice: json['bidPrice'] ?? 0,
      uploadDate: json['uploadDate'] ?? '',
      expireDate: json['expireDate'] ?? '',
      addDate: json['addDate'] ?? '',
      transmissionType: json['transmissionType'] ?? '',
      description: json['description'] ?? '',
      company: json['company'] ?? '',
      images: List<String>.from(json['images'] ?? []),
      auctions: (json['auctions'] as List<dynamic>)
          .map((bid) => Auction.fromJson(bid))
          .toList(),
    );
  }

  void addAuction(Auction auction) {
    auctions.add(auction);
  }

  void removeAuctionByParticipantId(String participantId) {
    auctions.removeWhere((auction) => auction.participantId == participantId);
  }

  Map<String, dynamic> toJson() {
    return {
      'carId': carId,
      'model': model,
      'paidBy': paidBy,
      'bidPrice': bidPrice,
      'paid': paid,
      'available': available,
      'make': make,
      'year': year,
      'seller': seller,
      'sellerId': sellerId,
      'sellerPhone': sellerPhone,
      'type': _getTypeString(type),
      'price': price,
      'location': location,
      'mileage': mileage,
      'uploadDate': uploadDate,
      'addDate': addDate,
      'expireDate': expireDate,
      'transmissionType': transmissionType,
      'description': description,
      'company': company,
      'images': images,
      'auctions': auctions.map((bid) => bid.toJson()).toList(),
    };
  }

  static Type _parseType(String type) {
    switch (type) {
      case 'NEW':
        return Type.NEW;
      case 'USED':
        return Type.USED;
      case 'AUCTION':
        return Type.AUCTION;
      default:
        throw ArgumentError('Invalid type: $type');
    }
  }

  static String _getTypeString(Type type) {
    return type.toString().split('.').last;
  }
}
