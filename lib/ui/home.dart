import 'package:app/data/pokedex_repository.dart';
import 'package:app/domain/model.dart';
import 'package:app/ui/detail.dart';
import 'package:app/util/image_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:palette_generator/palette_generator.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text('Pokedex', style: TextStyle(color: Colors.white),),
        ),
        backgroundColor: const Color(0xFFD53B47),
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Color(0xFFD53B47),
        ),
      ),
      body: PokemonListPage(),
      backgroundColor: Colors.white,
    );
  }
}

class PokemonListPage extends StatefulWidget {
  const PokemonListPage({Key? key}) : super(key: key);

  @override
  State<PokemonListPage> createState() => _PokemonListPageState();
}

class _PokemonListPageState extends State<PokemonListPage> {
  late Future<List<Pokemon>> pokemonList;
  late Future<Pokedex> response;

  @override
  void initState() {
    super.initState();
    response = fetchData();
  }

  fetchData() => PokedexRepository().all();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Pokedex>(
      future: response,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          Pokedex response = snapshot.data as Pokedex;
          List<Pokemon> list = response.results;
          return GridView.builder(
            padding: const EdgeInsets.all(10),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
            ),
            itemBuilder: (context, index) => PokemonItem(name: list[index].name, url: list[index].url,),
            itemCount: list.length,
          );
        } else if (snapshot.hasError) {
          return Text("${snapshot.error}");
        }

        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}

class PokemonItem extends StatefulWidget {
  const PokemonItem({Key? key, required this.name, required this.url}) : super(key: key);
  final String name;
  final String url;

  @override
  State<PokemonItem> createState() => _PokemonItemState();
}

class _PokemonItemState extends State<PokemonItem> {
  Color backgroundColor = Colors.transparent;
  late Image image;


  @override
  void initState() {
    super.initState();
    _loadImage();
    _updatePaletteGenerator();
  }

  _loadImage() async {
    image = Image.network(ImageHelper.pokemonImageUrl(widget.url));
  }

  _updatePaletteGenerator() async {
    PaletteGenerator paletteGenerator = await PaletteGenerator.fromImageProvider(
        image.image,
        size: const Size(100, 100)
    );
    setState(() {
      backgroundColor = paletteGenerator.dominantColor?.color ?? Colors.transparent;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        decoration: BoxDecoration(
          color: backgroundColor,
          border: Border.all(color: Colors.grey, width: 1),
          borderRadius: const BorderRadius.all(Radius.circular(10))
        ),
        child: Column(
          children: [
            Expanded(
                child: Image(image: image.image)
            ),
            Text(widget.name),
          ],
        ),
      ),
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => DetailPage(pokemon: Pokemon(name: widget.name, url: widget.url),)
            )
        );
      },
    );
  }

}
