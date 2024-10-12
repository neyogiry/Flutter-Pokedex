import 'dart:convert';
import 'package:app/domain/pokemon_detail.dart';
import 'package:http/http.dart' as http;

class PokemonDetailRepository {

  Future<PokemonDetail> details(String url) async {
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      return PokemonDetail.fromJson(jsonDecode(response.body));
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load pokemon details');
    }
  }

}