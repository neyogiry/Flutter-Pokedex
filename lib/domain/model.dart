
class Pokedex {
  final List<Pokemon> results;

  const Pokedex({
    required this.results
  });

  factory Pokedex.fromJson(Map<String, dynamic> json) {
    return Pokedex(
      results: List<Pokemon>.from(json["results"].map((x) => Pokemon.fromJson(x)))
    );
  }

}

class Pokemon {
  final String name;
  final String url;

  const Pokemon({
    required this.name,
    required this.url,
  });

  factory Pokemon.fromJson(Map<String, dynamic> json) {
    return Pokemon(
      name: json['name'],
      url: json["url"],
    );
  }

  Map<String, dynamic> toJson() => {
    "name": name,
    "url": url,
  };

}