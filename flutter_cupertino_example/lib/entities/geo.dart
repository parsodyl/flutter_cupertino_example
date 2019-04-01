class Geo {
  String lat;
  String lng;

  Geo({
    this.lat,
    this.lng,
  });

  static Geo fromJson(Map<String, dynamic> json) {
    return Geo(
      lat: json['lat'],
      lng: json['lng'],
    );
  }

  Map<String, dynamic> toJson() => {
        'lat': lat,
        'lng': lng,
      };
}
