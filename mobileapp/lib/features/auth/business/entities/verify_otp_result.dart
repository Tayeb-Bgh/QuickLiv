class VerifyOtpResult {
  final bool success;
  final String? role; // "client", "livreur", ou null

  VerifyOtpResult({required this.success, required this.role});
}
