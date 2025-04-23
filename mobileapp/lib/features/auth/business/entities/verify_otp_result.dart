class VerifyOtpResult {
  final bool success;
  final String token;
  final String? role; // "Customer", "Deliverer", or "null"

  VerifyOtpResult({required this.success,required this.token, required this.role});
}
