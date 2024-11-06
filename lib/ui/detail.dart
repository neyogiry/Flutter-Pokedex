import 'package:app/data/detail_repository.dart';
import 'package:app/domain/model.dart';
import 'package:app/domain/pokemon_detail.dart';
import 'package:app/util/extensions.dart';
import 'package:flutter/material.dart';

import '../util/image_helper.dart';

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
  late Image image;
  late Future<PokemonDetail> response;

  @override
  void initState() {
    super.initState();
    _loadImage();
    response = fetchData();
  }

  fetchData() => PokemonDetailRepository().details(widget.pokemon.url);

  _loadImage() async {
    image = Image.network(ImageHelper.pokemonImageUrl(widget.pokemon.url),);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.chevron_left, size: 36, color: Colors.white,)
        ),
        backgroundColor: Colors.teal,
      ),
      body: SafeArea(
        child: FutureBuilder<PokemonDetail>(
          future: response,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              PokemonDetail response = snapshot.data as PokemonDetail;
              return Column(
                children: [
                  Container(height: 200,),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20)
                      ),
                      margin: const EdgeInsets.all(8.0),
                      width: double.infinity,
                      height: double.infinity,
                      child: Stack(
                          alignment: Alignment.topCenter,
                          clipBehavior: Clip.none,
                          children: [
                            Positioned(
                                top: -150,
                                child: Column(
                                  children: [
                                    Image(image: image.image, width: 200, height: 200,),
                                    Text(response.name.capitalize(), style: const TextStyle(fontSize: 24))
                                  ],
                                )
                            ),
                          ]
                      ),
                    ),
                  )
                ],
              );
            } else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            }
            return const Center(child: CircularProgressIndicator());
          },
        ),
      ),
      backgroundColor: Colors.teal,
    );
  }

}