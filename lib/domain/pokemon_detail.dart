
class PokemonDetail {
  final String name;

  const PokemonDetail({
    required this.name
});

  factory PokemonDetail.fromJson(Map<String, dynamic> json) {
    return PokemonDetail(
      name: json['name'],
    );
  }

}