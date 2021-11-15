class StreamModel {
  late String id;
  late String streamName;

  StreamModel({
    required this.id,
    required this.streamName,
  });

  factory StreamModel.fromJson(Map<String, dynamic> json) {
    return StreamModel(
      id: json['id'],
      streamName: json['title'],
    );
  }
}
