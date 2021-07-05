class Model {
  String? modelAdi;
  int? fiyat;
  bool? benzilli;

  Model({required this.modelAdi, required this.fiyat, required this.benzilli});

  Model.fromJson(Map<String, dynamic> json) {
    modelAdi = json['model_adi'];
    fiyat = json['fiyat'];
    benzilli = json['benzilli'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['model_adi'] = this.modelAdi;
    data['fiyat'] = this.fiyat;
    data['benzilli'] = this.benzilli;
    return data;
  }
}
