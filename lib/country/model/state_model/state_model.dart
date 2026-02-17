class StateModel {
  final int id;
  final String name;
  final int countryId;
  final String countryCode;

  StateModel({
    required this.id,
    required this.name,
    required this.countryId,
    required this.countryCode,
  });

  factory StateModel.fromJson(Map<String, dynamic> json) {
    return StateModel(
      id: json['id'],
      name: json['name'],
      countryId: json['country_id'],
      countryCode: json['country_code'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'country_id': countryId,
      'country_code': countryCode,
    };
  }
}