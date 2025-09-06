class UserModel {
  final String id;
  final String email;
  String name;
  final String createdAt;
  String? updatedAt;

  UserModel({
    required this.id,
    required this.email,
    required this.name,
    required this.createdAt,
    this.updatedAt,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      email: json['email'],
      name: json['name'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'name': name,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }
}
