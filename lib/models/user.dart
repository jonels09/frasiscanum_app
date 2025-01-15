class User {
  final String firstName;
  final String lastName;
  final String level;
  final String gender; // Changed from isMale to gender

  User({
    required this.firstName,
    required this.lastName,
    required this.level,
    required this.gender, // Use 'male' or 'female' as values
  });

  Map<String, dynamic> toJson() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'level': level,
      'gender': gender,
    };
  }

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
      level: json['level'] as String,
      gender: json['gender'] as String,
    );
  }
}
