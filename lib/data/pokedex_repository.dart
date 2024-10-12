import 'dart:convert';
import 'package:app/domain/model.dart';
import 'package:http/http.dart' as http;
import '../util/constants.dart' as constants;

class PokedexRepository {

  Future<Pokedex> all() async {
    final response = await http.get(Uri.parse(constants.baseUrl + constants.pokedexEndpoint));

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      return Pokedex.fromJson(jsonDecode(response.body));
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load pokedex');
    }
  }

}