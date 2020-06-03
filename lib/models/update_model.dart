class UpdateModel {
  List<ReleaseModel> android;
  List<ReleaseModel> ios;

  UpdateModel.fromJson(Map<String, dynamic> json) {
    this.android = (json['android'] as List) != null
        ? (json['android'] as List)
            .map((i) => ReleaseModel.fromJson(i))
            .toList()
        : null;
    this.ios = (json['ios'] as List) != null
        ? (json['ios'] as List).map((i) => ReleaseModel.fromJson(i)).toList()
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['android'] = this.android != null
        ? this.android.map((i) => i.toJson()).toList()
        : null;
    data['ios'] =
        this.ios != null ? this.ios.map((i) => i.toJson()).toList() : null;
    return data;
  }
}

class ReleaseModel {
  int build;
  String version;
  String url;
  bool force;
  List<String> clog;

  ReleaseModel.fromJson(Map<String, dynamic> json) {
    build = json['build'];
    version = json['version'];
    url = json['url'];
    force = json['force'];
    clog = json['clog']?.cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['build'] = this.build;
    data['version'] = this.version;
    data['url'] = this.url;
    data['force'] = this.force;
    data['clog'] = this.clog;
    return data;
  }
}
