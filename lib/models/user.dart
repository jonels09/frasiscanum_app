class User {
  final String firstName;
  final String lastName;
  final String level;
  final String gender;

  User({
    required this.firstName,
    required this.lastName,
    required this.level,
    required this.gender,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      firstName: json['firstName'],
      lastName: json['lastName'],
      level: json['level'],
      gender: json['gender'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'level': level,
      'gender': gender,
    };
  }
}
