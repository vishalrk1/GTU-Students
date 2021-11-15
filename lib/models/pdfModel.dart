class pdfModel {
  final List<String> pdfUrl;
  final List<String> unitName;

  pdfModel({required this.pdfUrl, required this.unitName});

  factory pdfModel.fromJson(Map<String, dynamic> json) {
    return pdfModel(
      pdfUrl: json['pdfUrl'],
      unitName: json['unitName'],
    );
  }
}
