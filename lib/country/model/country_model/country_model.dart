class CountryModel {
  final int id;
  final String name;
  final String iso2;
  final String phoneCode;
  final String currencySymbol;
  final String emojiU;
  final String emoji;

  CountryModel({
    required this.id,
    required this.name,
    required this.iso2,
    required this.phoneCode,
    required this.currencySymbol,
    required this.emojiU,
    required this.emoji,
  });

  factory CountryModel.fromJson(Map<String, dynamic> json) {
    return CountryModel(
      id: json['id'],
      name: json['name'],
      iso2: json['iso2'],
      phoneCode: json['phonecode'],
      currencySymbol: json['currency_symbol'],
      emojiU: json['emojiU'],
      emoji: json['emoji'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'iso2': iso2,
      'phonecode': phoneCode,
      'currency_symbol': currencySymbol,
      'emojiU': emojiU,
      'emoji': emoji,
    };
  }
}