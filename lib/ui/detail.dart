import 'package:app/data/detail_repository.dart';
import 'package:app/domain/model.dart';
import 'package:app/domain/pokemon_detail.dart';
import 'package:flutter/material.dart';

class DetailPage extends StatelessWidget {
  const DetailPage({Key? key, required this.pokemon}) : super(key: key);

  final Pokemon pokemon;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PokemonDetailPage(pokemon: pokemon,),
    );
  }
  
}

class PokemonDetailPage extends StatefulWidget {
  final Pokemon pokemon;

  const PokemonDetailPage({Key? key, required this.pokemon}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _PokemonDetailPageState();

}

class _PokemonDetailPageState extends State<PokemonDetailPage> {
  late Future<PokemonDetail> response;

  @override
  void initState() {
    super.initState();
    response = fetchData();
  }

  fetchData() => PokemonDetailRepository().details(widget.pokemon.url);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<PokemonDetail>(
      future: response,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          PokemonDetail response = snapshot.data as PokemonDetail;
          return Text("${response.name}",);
        } else if (snapshot.hasError) {
          return Text("${snapshot.error}");
        }

        return const Center(child: CircularProgressIndicator());
      },
    );
  }

}