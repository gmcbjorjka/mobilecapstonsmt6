class LoginHistoryModel {
  final String email;
  final String loginTime;
  final String ipAddress;
  final String device;

  LoginHistoryModel({
    required this.email,
    required this.loginTime,
    required this.ipAddress,
    required this.device,
  });

  factory LoginHistoryModel.fromJson(Map<String, dynamic> json) {
    return LoginHistoryModel(
      email: json['email'] ?? '-',
      loginTime: json['login_time'] ?? '-',
      ipAddress: json['ip_address'] ?? '-',
      device: json['device_info'] ?? 'unknown',
    );
  }
}
