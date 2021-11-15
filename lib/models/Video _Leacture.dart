class LeactureChannelModel {
  final String chName;
  final String ytlink;
  final String profileImage;

  LeactureChannelModel(
      {required this.chName, required this.ytlink, required this.profileImage});

  factory LeactureChannelModel.fromJson(Map<String, dynamic> data) {
    return LeactureChannelModel(
      chName: data['chName'] ?? 'channel Name',
      ytlink: data['url'],
      profileImage: data['image'] ?? '',
    );
  }
}
