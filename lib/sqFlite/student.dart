final String tableUser = 'User';

class UserFields {
  static final List<String> values = [
    /// Add all fields
    id,
    name,
    userImage,
    email,
    dateOfBirth
  ];

  static final String id = '_id';
  static final String name = 'name';
  static final String userImage = 'userImage';
  static final String email = 'email';
  static final String dateOfBirth = 'dateOfBirth';
}

class User {
  final int? id;
  final String name;
  final String userImage;
  final String email;
  final String dateOfBirth;

  const User({
    this.id,
    required this.name,
    required this.userImage,
    required this.email,
    required this.dateOfBirth,
  });

  User copy({
    int? id,
    String? name,
    String? userImage,
    String? email,
    String? dateOfBirth,
  }) =>
      User(
        id: id ?? this.id,
        name: name ?? this.name,
        userImage: userImage ?? this.userImage,
        email: email ?? this.email,
        dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      );

  static User fromJson(Map<String, Object?> json) => User(
        id: json[UserFields.id] as int?,
        name: json[UserFields.name] as String,
        userImage: json[UserFields.userImage] as String,
        email: json[UserFields.email] as String,
        dateOfBirth: json[UserFields.dateOfBirth] as String,
      );

  Map<String, Object?> toJson() => {
        UserFields.id: id,
        UserFields.name: name,
        UserFields.userImage: userImage,
        UserFields.email: email,
        UserFields.dateOfBirth: dateOfBirth,
      };
}
