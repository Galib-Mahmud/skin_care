class ReadingModel {
  Skincare? skincare;
  Skincare? devotion;

  ReadingModel({this.skincare, this.devotion});

  ReadingModel.fromJson(Map<String, dynamic> json) {
    skincare = json['skincare'] != null
        ? new Skincare.fromJson(json['skincare'])
        : null;
    devotion = json['devotion'] != null
        ? new Skincare.fromJson(json['devotion'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.skincare != null) {
      data['skincare'] = this.skincare!.toJson();
    }
    if (this.devotion != null) {
      data['devotion'] = this.devotion!.toJson();
    }
    return data;
  }
}

class Skincare {
  String? title;
  String? content;

  Skincare({this.title, this.content});

  Skincare.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    content = json['content'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['content'] = this.content;
    return data;
  }
}
