import 'dart:convert';

ReferenceModel referenceModelFromJson(String str) => ReferenceModel.fromJson(json.decode(str));

String referenceModelToJson(ReferenceModel data) => json.encode(data.toJson());

class ReferenceModel {
  ReferenceModel({
    required this.code,
    required this.status,
    required this.copyright,
    required this.attributionText,
    required this.attributionHtml,
    required this.etag,
    required this.data,
  });

  int code;
  String status;
  String copyright;
  String attributionText;
  String attributionHtml;
  String etag;
  Data data;

  factory ReferenceModel.fromJson(Map<String, dynamic> json) => ReferenceModel(
    code: json["code"],
    status: json["status"],
    copyright: json["copyright"],
    attributionText: json["attributionText"],
    attributionHtml: json["attributionHTML"],
    etag: json["etag"],
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "status": status,
    "copyright": copyright,
    "attributionText": attributionText,
    "attributionHTML": attributionHtml,
    "etag": etag,
    "data": data.toJson(),
  };
}

class Data {
  Data({
    required this.offset,
    required this.limit,
    required this.total,
    required this.count,
    required this.results,
  });

  int offset;
  int limit;
  int total;
  int count;
  List<Result> results;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    offset: json["offset"],
    limit: json["limit"],
    total: json["total"],
    count: json["count"],
    results: List<Result>.from(json["results"].map((x) => Result.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "offset": offset,
    "limit": limit,
    "total": total,
    "count": count,
    "results": List<dynamic>.from(results.map((x) => x.toJson())),
  };
}

class Result {
  Result({
    this.id,
    this.title,
    this.description,
    this.resourceUri,
    this.modified,
    this.thumbnail,
    this.creators,
    this.characters,
  });

  int? id;
  String? title;
  String? description;
  String? resourceUri;
  String? modified;
  Thumbnail? thumbnail;
  Creators? creators;
  Characters? characters;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    id: json["id"],
    title: json["title"],
    description: json["description"] ?? "-",
    resourceUri: json["resourceURI"],
    modified: json["modified"],
    thumbnail: json["thumbnail"] != null ? Thumbnail.fromJson(json["thumbnail"]) : null,
    creators: json["creators"] != null ? Creators.fromJson(json["creators"]): null,
    characters: json["characters"] != null ? Characters.fromJson(json["characters"]): null,
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "description": description,
    "resourceURI": resourceUri,
    "modified": modified,
    "thumbnail": thumbnail!.toJson(),
    "creators": creators!.toJson(),
    "characters": characters!.toJson(),
  };
}

class Characters {
  Characters({
    required this.available,
    required this.collectionUri,
    required this.items,
    required this.returned,
  });

  int available;
  String collectionUri;
  List<Next> items;
  int returned;

  factory Characters.fromJson(Map<String, dynamic> json) => Characters(
    available: json["available"],
    collectionUri: json["collectionURI"],
    items: List<Next>.from(json["items"].map((x) => Next.fromJson(x))),
    returned: json["returned"],
  );

  Map<String, dynamic> toJson() => {
    "available": available,
    "collectionURI": collectionUri,
    "items": List<dynamic>.from(items.map((x) => x.toJson())),
    "returned": returned,
  };
}

class Creators {
  Creators({
    required this.available,
    required this.collectionUri,
    required this.items,
    required this.returned,
  });

  int available;
  String collectionUri;
  List<CreatorsItem> items;
  int returned;

  factory Creators.fromJson(Map<String, dynamic> json) => Creators(
    available: json["available"],
    collectionUri: json["collectionURI"],
    items: List<CreatorsItem>.from(json["items"].map((x) => CreatorsItem.fromJson(x))),
    returned: json["returned"],
  );

  Map<String, dynamic> toJson() => {
    "available": available,
    "collectionURI": collectionUri,
    "items": List<dynamic>.from(items.map((x) => x.toJson())),
    "returned": returned,
  };
}

class CreatorsItem {
  CreatorsItem({
    required this.resourceUri,
    required this.name,
    required this.role,
  });

  String resourceUri;
  String name;
  String role;

  factory CreatorsItem.fromJson(Map<String, dynamic> json) => CreatorsItem(
    resourceUri: json["resourceURI"],
    name: json["name"],
    role: json["role"],
  );

  Map<String, dynamic> toJson() => {
    "resourceURI": resourceUri,
    "name": name,
    "role": role,
  };
}

class Next {
  Next({
    required this.resourceUri,
    required this.name,
  });

  String resourceUri;
  String name;

  factory Next.fromJson(Map<String, dynamic> json) => Next(
    resourceUri: json["resourceURI"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "resourceURI": resourceUri,
    "name": name,
  };
}

class Stories {
  Stories({
    required this.available,
    required this.collectionUri,
    required this.items,
    required this.returned,
  });

  int available;
  String collectionUri;
  List<StoriesItem> items;
  int returned;

  factory Stories.fromJson(Map<String, dynamic> json) => Stories(
    available: json["available"],
    collectionUri: json["collectionURI"],
    items: List<StoriesItem>.from(json["items"].map((x) => StoriesItem.fromJson(x))),
    returned: json["returned"],
  );

  Map<String, dynamic> toJson() => {
    "available": available,
    "collectionURI": collectionUri,
    "items": List<dynamic>.from(items.map((x) => x.toJson())),
    "returned": returned,
  };
}

class StoriesItem {
  StoriesItem({
    required this.resourceUri,
    required this.name,
    required this.type,
  });

  String resourceUri;
  String name;
  Type type;

  factory StoriesItem.fromJson(Map<String, dynamic> json) => StoriesItem(
    resourceUri: json["resourceURI"],
    name: json["name"],
    type: typeValues.map[json["type"]]!,
  );

  Map<String, dynamic> toJson() => {
    "resourceURI": resourceUri,
    "name": name,
    "type": typeValues.reverse[type],
  };
}

enum Type { EMPTY, INTERIOR_STORY, COVER, TEXT_STORY }

final typeValues = EnumValues({
  "cover": Type.COVER,
  "": Type.EMPTY,
  "interiorStory": Type.INTERIOR_STORY,
  "text story": Type.TEXT_STORY
});

class Thumbnail {
  Thumbnail({
    required this.path,
    required this.extension,
  });

  String path;
  String extension;

  factory Thumbnail.fromJson(Map<String, dynamic> json) => Thumbnail(
    path: json["path"],
    extension: json["extension"].toString(),
  );

  Map<String, dynamic> toJson() => {
    "path": path,
    "extension": extension,
  };
}

class Url {
  Url({
    required this.type,
    required this.url,
  });

  String type;
  String url;

  factory Url.fromJson(Map<String, dynamic> json) => Url(
    type: json["type"],
    url: json["url"],
  );

  Map<String, dynamic> toJson() => {
    "type": type,
    "url": url,
  };
}

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
