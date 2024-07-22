class UserData {
  final int id;
  final String name;
  final String phone;
  final String email;
  final String avatar;

  UserData({
    required this.id,
    required this.name,
    required this.phone,
    required this.email,
    required this.avatar,
  });

  factory UserData.fromJson(Map<String, dynamic> json) {
    final data = json['data'] as Map<String, dynamic>;
    return UserData(
      id: data['id'] ?? 0,
      name: data['name'] ?? 'Unknown Name',
      phone: data['phone'] ?? 'Unknown Phone',
      email: data['email'] ?? 'Unknown Email',
      avatar: data['avatar'] ?? '',
    );
  }
}
