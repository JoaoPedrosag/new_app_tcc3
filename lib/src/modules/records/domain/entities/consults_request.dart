class ConsultsRequest {
  final int id;
  final String convertedText;
  final String audioUrl;
  final String createdAt;

  ConsultsRequest({
    required this.id,
    required this.convertedText,
    required this.audioUrl,
    required this.createdAt,
  });

  factory ConsultsRequest.fromJson(Map<String, dynamic> json) {
    return ConsultsRequest(
      id: json['id'],
      convertedText: json['converted_text'],
      audioUrl: json['audio_path'],
      createdAt: json['consultation_date'],
    );
  }
}
