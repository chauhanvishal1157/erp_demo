class CityModel {
  final int id;
  final String name;
  final int stateId;
  final String stateCode;
  final String countryCode;

  CityModel({
    required this.id,
    required this.name,
    required this.stateId,
    required this.stateCode,
    required this.countryCode,
  });

  factory CityModel.fromJson(Map<String, dynamic> json) {
    return CityModel(
      id: json['id'],
      name: json['name'],
      stateId: json['state_id'],
      stateCode: json['state_code'],
      countryCode: json['country_code'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'state_id': stateId,
      'state_code': stateCode,
      'country_code': countryCode,
    };
  }
}