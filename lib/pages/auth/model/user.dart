class UserData {
  final String uid;
  final String userName;
  final String phoneNumber;
  final bool blocked;
  final bool admin;

  UserData({
    required this.uid,
    required this.userName,
    required this.phoneNumber,
    required this.blocked,
    required this.admin,
  });

  factory UserData.fromMap(Map<String, dynamic> map) {
    return UserData(
      uid: map['uid'],
      userName: map['userName'],
      phoneNumber: map['phoneNumber'],
      blocked: map['blocked'] ?? false,
      admin: map['admin'] ?? false,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'userName': userName,
      'phoneNumber': phoneNumber,
      'blocked': blocked,
      'admin': admin,
    };
  }
}
