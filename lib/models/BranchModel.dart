class BranchModel {
  late String id;
  late String branchName;

  BranchModel({
    required this.id,
    required this.branchName,
  });

  factory BranchModel.fromJson(Map<String, dynamic> json) {
    return BranchModel(
      id: json['id'],
      branchName: json['title'],
    );
  }
}
