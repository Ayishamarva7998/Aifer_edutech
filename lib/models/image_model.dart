class ImageModel {
  String? id;
  String? slug;
  UrlsModel? url;
  LinksModel? links;

  ImageModel({
    required this.id,
    required this.links,
    required this.slug,
    required this.url,
  });
  factory ImageModel.fromJson(Map<String, dynamic> json) {
    return ImageModel(
      id: json["id"],
      links: json["links"] != null ? LinksModel.fromJson(json["links"]) : null,
      slug: json["slug"],
      url: json["urls"] != null ? UrlsModel.fromJson(json["urls"]) : null,
    );
  }
}

class UrlsModel {
  String? raw;
  String? full;
  String? regular;
  String? small;
  String? thumb;
  String? smallS3;

  UrlsModel(
      {required this.full,
      required this.raw,
      required this.regular,
      required this.small,
      required this.smallS3,
      required this.thumb});

  factory UrlsModel.fromJson(Map<String, dynamic> json) {
    return UrlsModel(
      full: json["full"],
      raw: json["raw"],
      regular: json["regular"],
      small: json["small"],
      smallS3: json["small_s3"],
      thumb: json["thumb"],
    );
  }
}

class LinksModel {
  String? download;

  LinksModel({
    required this.download,
  });

  factory LinksModel.fromJson(Map<String, dynamic> json) {
    return LinksModel(
      download: json["download"],
    );
  }
}
