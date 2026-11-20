class CovidData {
  final String country;
  final String flag;
  final int cases;
  final int todayCases;
  final int deaths;
  final int todayDeaths;
  final int recovered;
  final DateTime updated;

  CovidData({
    required this.country,
    required this.flag,
    required this.cases,
    required this.todayCases,
    required this.deaths,
    required this.todayDeaths,
    required this.recovered,
    required this.updated,
  });

  factory CovidData.fromJson(Map<String, dynamic> json) {
    // La API a veces entrega números como double o los omite: num? lo tolera.
    int toInt(dynamic v) => (v as num?)?.toInt() ?? 0;

    final info = json['countryInfo'];
    final flag = info is Map<String, dynamic>
        ? (info['flag'] as String? ?? '')
        : '';

    return CovidData(
      country: json['country'] as String,
      flag: flag,
      cases: toInt(json['cases']),
      todayCases: toInt(json['todayCases']),
      deaths: toInt(json['deaths']),
      todayDeaths: toInt(json['todayDeaths']),
      recovered: toInt(json['recovered']),
      updated: DateTime.fromMillisecondsSinceEpoch(toInt(json['updated'])),
    );
  }
} 