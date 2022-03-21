class Vocabulary {
  List<String>? th;
  List<String>? eng;

  Vocabulary({this.th, this.eng});

  Vocabulary.fromJson(Map<String, dynamic> json) {
    th = json['th'].cast<String>();
    eng = json['eng'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['th'] = this.th;
    data['eng'] = this.eng;
    return data;
  }
}