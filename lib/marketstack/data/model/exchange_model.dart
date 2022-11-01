import 'package:equatable/equatable.dart';

class ExchangeModel extends Equatable {
  final String name;
  final String acronym;
  final String mic;
  final String country;
  final String countryCode;
  final String city;
  final String website;

  const ExchangeModel({
    required this.name,
    required this.acronym,
    required this.mic,
    required this.country,
    required this.countryCode,
    required this.city,
    required this.website,
  });

  ExchangeModel copyWith({
    String? name,
    String? acronym,
    String? mic,
    String? country,
    String? countryCode,
    String? city,
    String? website,
  }) {
    return ExchangeModel(
      name: name ?? this.name,
      acronym: acronym ?? this.acronym,
      mic: mic ?? this.mic,
      country: country ?? this.country,
      countryCode: countryCode ?? this.countryCode,
      city: city ?? this.city,
      website: website ?? this.website,
    );
  }

  factory ExchangeModel.fromJson(Map<String, dynamic> json) => ExchangeModel(
        name: json["name"] ?? '',
        acronym: json["acronym"] ?? '',
        mic: json["mic"] ?? '',
        country: json["country"] ?? '',
        countryCode: json["country_code"] ?? '',
        city: json["city"] ?? '',
        website: json["website"] ?? '',
      );

  @override
  List<Object?> get props => [
        name,
        acronym,
        mic,
        country,
        countryCode,
        city,
        website,
      ];
}
